module Services
  module Accounts
    module Commands
      module Base
        class Structure
          include ActiveModel::Model

          attr_reader :result

          def initialize()
            super()
            @succeeded = false
            @result = {}
          end

          def call
            execute
            self
          end

          def no_errors?
            get_errors.blank?
          end

          def get_errors
            errors
          end

          def success?
            @succeeded || false
          end

          protected

          def execute
            raise NotImplementedError('execute method not implemented')
          end
        end
      end
    end
  end
end
