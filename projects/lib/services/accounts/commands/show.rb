module Services
  module Accounts
    module Commands
      class Show < Base::ApiClient
        def initialize(username:)
          super()
          @username = username
        end

        def execute
          @response = self.class.get("/accounts/#{username}/show")
          @succeeded = @response.code == 200

          @result = Services::Accounts::Models::User.new({ username: username }) if @succeeded
        end

        private

        attr_accessor :username

        def parse_response
          @response&.body && JSON.parse(@response.body)
        end
      end
    end
  end
end

