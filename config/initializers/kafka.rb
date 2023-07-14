require 'kafka'

KAFKA_URL = ENV.fetch('KAFKA_URL', 'localhost:9092').split(',').freeze

KAFKA = Kafka.new(KAFKA_URL, client_id: ENV.fetch('APP_NAME', 'facebook_api').downcase).freeze

KAFKA_MAX_RETRY = ENV.fetch('KAFKA_MAX_RETRY', 3).to_i.freeze