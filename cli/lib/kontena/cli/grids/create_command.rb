require_relative 'common'

module Kontena::Cli::Grids
  class CreateCommand < Kontena::Command
    include Kontena::Cli::Common
    include Common

    parameter "NAME", "Grid name"

    option "--initial-size", "INITIAL_SIZE", "Initial grid size (number of nodes)", default: 1
    option "--silent", :flag, "Reduce output verbosity"

    requires_current_master_token

    def execute
      payload = {
        name: name
      }
      begin
        if client.get("grids/#{self.name}")
          abort pastel.red("Grid '#{self.name}' already exists")
        end
      rescue Kontena::Errors::StandardError
      end
      payload[:initial_size] = initial_size if initial_size
      grid = nil
      if initial_size == 1
        warning "Option --initial-size=1 is only recommended for test/dev usage" unless running_silent?
      end
      spinner "Creating #{pastel.cyan(name)} grid " do
        grid = client.post('grids', payload)
      end
      if grid
        spinner "Switching scope to #{pastel.cyan(name)} grid " do
          config.current_grid = grid['name']
          config.write
        end
      end
    end
  end
end
