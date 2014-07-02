# S3Policy

Generate a signed S3 policy document for namespaced clientside uploads.

## Installation

Add this line to your application's Gemfile:

    gem 's3_policy'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install s3_policy

## Usage

```ruby
require 's3_policy'

policy = S3Policy.generate_policy_document(
  bucket: "my_awesome_bucket",
  namespace: "users/#{user_id}/"
)

signature = S3Policy.sign_document(policy, aws_secret_key)

# Give this to the client
{
  aws_access_key_id: aws_access_key_id,
  policy: policy,
  signature: signature
}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
