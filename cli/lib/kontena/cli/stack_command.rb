
class Kontena::Cli::StackCommand < Kontena::Command

  subcommand "create", "Create stack", load_subcommand('stacks/create_command')
  subcommand ["ls", "list"], "List stacks", load_subcommand('stacks/list_command')
  subcommand "show", "Show stack details", load_subcommand('stacks/show_command')
  subcommand "update", "Update stack", load_subcommand('stacks/update_command')
  subcommand "deploy", "Deploy Kontena stack", load_subcommand('stacks/deploy_command')
  subcommand ["remove","rm"], "Remove stack", load_subcommand('stacks/remove_command')
  
  def execute

  end
end