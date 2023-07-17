require "kafka"
class Kafka::KafkaBase
  # rails runner Kafka::KafkaBase.new.consumer
  # consumer chỉ lấy message được tạo ra sau khi nó được kích hoạt
  def consumer
    kafka = Kafka.new("broker.fxce-kafka-dev.vncdevs.com:31091")
    # Consumers with the same group id will form a Consumer Group together.
    consumer = kafka.consumer(group_id: 'fxce-loi-nguyen')
    consumer.subscribe('fxce-loi-nguyen')
    consumer.each_message do |message|
      puts "####### #{message.value}"
    end
  end

  # rails runner Kafka::KafkaBase.new.producer
  def producer
    kafka = Kafka.new("broker.fxce-kafka-dev.vncdevs.com:31091")
    10.times do |item|
      sleep 1
      kafka.deliver_message("Test Produce Message #{SecureRandom.hex}", topic: 'fxce-loi-nguyen')
    end
  end

  def producer_localhost
    10.times do |item|
      sleep 1
      KAFKA.deliver_message("Test Produce Message #{SecureRandom.hex} ===> #{item}", topic: 'telecom_italia_grid_dd')
    end
  end

  def consumer_localhost
    consumer = KAFKA.consumer(group_id: 'telecom_italia_grid_dd')
    consumer.subscribe('telecom_italia_grid_dd')
    consumer.each_message do |message|
      puts "###### #{message.value}"
    end
  end

end

# hoặc có thể chạy trong rails console

# note
# /home/nguyenloi/kafka/kafka-3.5.0-src download from https://kafka.apache.org/downloads
# cd /home/nguyenloi/kafka/kafka-3.5.0-src

# to start kafka run:

# bin/zookeeper-server-start.sh config/zookeeper.properties
# bin/kafka-server-start.sh config/server.properties


