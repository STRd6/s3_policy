require 'test/unit'
require 's3_policy'

class S3PolicyTest < Test::Unit::TestCase
  def test_signing_document
    aws_access_key_id = "AKIAIOSFODNN7EXAMPLE"

    policy_document = {
      "expiration"=> "2013-08-06T12:00:00.000Z",
      "conditions"=> [
        {"bucket"=> "examplebucket"},
        ["starts-with", "$key", "user/user1/"],
        {"acl"=> "public-read"},
        {"success_action_redirect"=> "http://acl6.s3.amazonaws.com/successful_upload.html"},
        ["starts-with", "$Content-Type", "image/"],
        {"x-amz-meta-uuid"=> "14365123651274"},
        ["starts-with", "$x-amz-meta-tag", ""],
        {"x-amz-credential"=> "AKIAIOSFODNN7EXAMPLE/20130806/us-east-1/s3/aws4_request"},
        {"x-amz-algorithm"=> "AWS4-HMAC-SHA256"},
        {"x-amz-date"=> "20130806T000000Z" }
      ]
    }

    assert_equal "eyJleHBpcmF0aW9uIjoiMjAxMy0wOC0wNlQxMjowMDowMC4wMDBaIiwiY29uZGl0aW9ucyI6W3siYnVja2V0IjoiZXhhbXBsZWJ1Y2tldCJ9LFsic3RhcnRzLXdpdGgiLCIka2V5IiwidXNlci91c2VyMS8iXSx7ImFjbCI6InB1YmxpYy1yZWFkIn0seyJzdWNjZXNzX2FjdGlvbl9yZWRpcmVjdCI6Imh0dHA6Ly9hY2w2LnMzLmFtYXpvbmF3cy5jb20vc3VjY2Vzc2Z1bF91cGxvYWQuaHRtbCJ9LFsic3RhcnRzLXdpdGgiLCIkQ29udGVudC1UeXBlIiwiaW1hZ2UvIl0seyJ4LWFtei1tZXRhLXV1aWQiOiIxNDM2NTEyMzY1MTI3NCJ9LFsic3RhcnRzLXdpdGgiLCIkeC1hbXotbWV0YS10YWciLCIiXSx7IngtYW16LWNyZWRlbnRpYWwiOiJBS0lBSU9TRk9ETk43RVhBTVBMRS8yMDEzMDgwNi91cy1lYXN0LTEvczMvYXdzNF9yZXF1ZXN0In0seyJ4LWFtei1hbGdvcml0aG0iOiJBV1M0LUhNQUMtU0hBMjU2In0seyJ4LWFtei1kYXRlIjoiMjAxMzA4MDZUMDAwMDAwWiJ9XX0=",
      S3Policy.encode_document(policy_document)

  end

  def test_signing_encoded_document
    aws_secret_key = "uV3F3YluFJax1cknvbcGwgjvx4QpvB+leU8dUj2o"
    encoded_document = "eyAiZXhwaXJhdGlvbiI6ICIyMDA3LTEyLTAxVDEyOjAwOjAwLjAwMFoiLAogICJjb25kaXRpb25zIjogWwogICAgeyJidWNrZXQiOiAiam9obnNtaXRoIiB9LAogICAgWyJzdGFydHMtd2l0aCIsICIka2V5IiwgInVzZXIvZXJpYy8iXSwKICAgIHsiYWNsIjogInB1YmxpYy1yZWFkIiB9LAogICAgeyJyZWRpcmVjdCI6ICJodHRwOi8vam9obnNtaXRoLnMzLmFtYXpvbmF3cy5jb20vc3VjY2Vzc2Z1bF91cGxvYWQuaHRtbCIgfSwKICAgIFsic3RhcnRzLXdpdGgiLCAiJENvbnRlbnQtVHlwZSIsICJpbWFnZS8iXSwKICAgIHsieC1hbXotbWV0YS11dWlkIjogIjE0MzY1MTIzNjUxMjc0In0sCiAgICBbInN0YXJ0cy13aXRoIiwgIiR4LWFtei1tZXRhLXRhZyIsICIiXSwKICBdCn0K"

    assert_equal "2qCp0odXe7A9IYyUVqn0w2adtCA=",
      S3Policy.sign_encoded_document(encoded_document, aws_secret_key)
  end

  def test_generate_policy_document
    assert S3Policy.generate_policy_document(bucket: 'yolo')
  end
end
