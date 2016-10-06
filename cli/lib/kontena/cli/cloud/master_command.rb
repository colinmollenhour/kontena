
module Kontena::Cli::Cloud
  class MasterCommand < Kontena::Command
    include Kontena::Cli::Common

    subcommand ['list', 'ls'], "List masters in Kontena Cloud", load_subcommand('cloud/master/list_command')
    subcommand "add", "Register a master in Kontena Cloud", load_subcommand('cloud/master/add_command')
    subcommand "delete", "Delete a master in Kontena Cloud", load_subcommand('cloud/master/delete_command')
    subcommand "show", "Show master settings in Kontena Cloud", load_subcommand('cloud/master/show_command')
    subcommand "update", "Update master settings in Kontena Cloud", load_subcommand('cloud/master/update_command')

    def execute
    end
  end
end