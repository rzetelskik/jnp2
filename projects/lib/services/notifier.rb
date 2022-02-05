require 'json'

class Services::Notifier
  def initialize(routing_key:, resource:, action:, payload:)
    @routing_key = routing_key
    @resource = resource
    @action = action
    @payload = payload
  end

  def call
    publish
  end

  private

  attr_accessor :routing_key, :resource, :action, :payload

  def publish
    exchange.publish({ resource: resource, action: action, payload: payload }.to_json, routing_key: routing_key)
    connection.close
  end

  def connection
    @connection ||= begin
                      connection = Bunny.new(host: Rails.configuration.rabbitmq_service_host)
                      connection.start
                    end
  end

  def exchange
    @exchange ||= channel.direct('projects')
  end

  def channel
    @channel ||= connection.create_channel
  end
end