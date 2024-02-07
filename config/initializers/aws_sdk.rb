require 'aws-sdk'

Aws.config.update(
  endpoint: 'https://' + (ENV["STACKHERO_MINIO_HOST"] || 'minio.stackhero-network.com'),
  access_key_id: ENV["STACKHERO_MINIO_ACCESS_KEY"],
  secret_access_key: ENV["STACKHERO_MINIO_SECRET_KEY"],
  force_path_style: true,
  region: 'eu-central-1',
)
