require "s3_policy/version"

require "base64"
require "date"
require "digest/sha1"
require "json"
require "openssl"
require "time"

module S3Policy
  class << self
    def generate_policy_document(options={})
      # Required
      bucket = options[:bucket]

      # Optional
      acl = options[:acl] || "public-read"
      content_type = options[:content_type] || ""
      expiration = options[:expiration] || one_week_from_now
      max_size = options[:max_size] || 1024 * 1024 * 10
      namespace = options[:namespace] || ""

      policy_document = {
        expiration: expiration,
        conditions: [
          { bucket: bucket},
          ["starts-with", "$key", namespace],
          { acl: acl},
          ["starts-with", "$Cache-Control", ""],
          ["starts-with", "$Content-Type", content_type],
          ["content-length-range", 0, max_size]
        ]
      }
    end

    def one_week_from_now
      (DateTime.now + 7).to_time.utc.iso8601
    end

    def encode_document(policy_document)
      Base64.strict_encode64(policy_document.to_json)
    end

    def sign_document(policy_document, secret_key)
      sign_encoded_document(encode_document(policy_document), secret_key)
    end

    def sign_encoded_document(encoded_policy_document, secret_key)
      Base64.strict_encode64(
        OpenSSL::HMAC.digest(
          OpenSSL::Digest.new('sha1'),
          secret_key,
          encoded_policy_document
        )
      )
    end
  end
end
