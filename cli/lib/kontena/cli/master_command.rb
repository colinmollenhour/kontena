class Kontena::Cli::MasterCommand < Kontena::Command
  include Kontena::Util

  subcommand ["list", "ls"], "List masters where client has logged in", load_subcommand('master/list_command')
  subcommand ["config", "cfg"], "Configure master settings", load_subcommand('master/config_command')
  subcommand "use", "Switch to use selected master", load_subcommand('master/use_command')
  subcommand "users", "Users specific commands", load_subcommand('master/users_command')
  subcommand "current", "Show current master details", load_subcommand('master/current_command')
  subcommand "login", "Authenticate to Kontena Master", load_subcommand('master/login_command')
  subcommand "token", "Manage Kontena Master access tokens", load_subcommand('master/token_command')
  subcommand "join", "Join Kontena Master using an invitation code", load_subcommand('master/join_command')
  subcommand "audit-log", "Show master audit logs", load_subcommand('master/audit_log_command')
  subcommand "create", "Install a new Kontena Master", load_subcommand('master/create_command') if experimental?

  def execute
  end
end
