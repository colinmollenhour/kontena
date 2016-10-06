require_relative '../../../common'

module Kontena::Cli::Master::Users
  module Roles
    class AddCommand < Kontena::Command
      include Kontena::Cli::Common

      parameter "ROLE", "Role name"
      parameter "USER ...", "List of users"

      requires_current_master_token

      def execute
        data = { role: role }

        user_list.each do |email|
          begin
            response = client.post("users/#{email}/roles", data)
            puts "Added role #{role} to #{email}"
          rescue => exc
            puts "Failed to add role #{role} to #{email}".colorize(:red)
            puts exc.message
          end
        end
      end
    end
  end
end
