require_relative 'common'

module Kontena::Cli::Stacks
  class ShowCommand < Kontena::Command
    include Kontena::Cli::Common
    include Kontena::Cli::GridOptions
    include Common

    parameter "NAME", "Service name"

    requires_current_master_token

    def execute
      show_stack(name)
      
    end

    private

    def show_stack(name)
      stack = client.get("stacks/#{current_grid}/#{name}")

      puts stack

      puts "#{stack['id']}:"
      puts "  state: #{stack['state']}"
      puts "  created_at: #{stack['created_at']}"
      puts "  updated_at: #{stack['updated_at']}"
      puts "  version: #{stack['version']}"
      puts "  services:"
      stack['grid_services'].each do |service|
        puts "    id: #{service['id']}"
      end
    end

  end
end
