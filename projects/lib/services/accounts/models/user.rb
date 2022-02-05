module Services
  module Accounts
    module Models
      class User
        include ActiveModel::Model
        attr_accessor :username

        def initialize(args)
          self.assign_attributes(args)
        end

        class << self
          def find_by_username(username)
            command = Services::Accounts::Commands::Show.new(username: username).call
            command.success? ? command.result : nil
          end
        end
      end
    end
  end
end
