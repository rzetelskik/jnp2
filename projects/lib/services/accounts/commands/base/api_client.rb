module Services
  module Accounts
    module Commands
      module Base
        class ApiClient < Structure
          include HTTParty
          base_uri Rails.configuration.accounts_service_host

          attr_reader :response

          def initialize()
            super()
            @httparty_options = {query: {}, body: {}, timeout: 10}
            @response = nil
          end

          def call
            super
          rescue *ALL_NET_HTTP_ERRORS
            errors.add(:base, "Accounts service is temporatily unavailable")
            self
          end

          def set_query(params)
            @httparty_options[:query] = params
          end

          def set_params(params)
            @httparty_options[:body] = params
          end

          def get_errors
            return super unless @response&.body&.present?

            received_errors = JSON.parse(@response&.body)&.dig('error')
            errors.add(:base, received_errors) unless @succeeded or received_errors.nil?
            super
          end

          private

          ALL_NET_HTTP_ERRORS = [
              Timeout::Error, Errno::EINVAL, Errno::ECONNREFUSED, Errno::EADDRNOTAVAIL, Errno::ECONNRESET,
              EOFError, Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError
          ]
        end
      end
    end
  end
end
