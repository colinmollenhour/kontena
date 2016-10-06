require_relative 'services_helper'

module Kontena::Cli::Services
  class MonitorCommand < Kontena::Command
    include Kontena::Cli::Common
    include Kontena::Cli::GridOptions
    include ServicesHelper

    parameter "NAME", "Service name"
    option "--interval", "SECONDS", "How often view is refreshed", default: 2

    requires_current_master_token

    def execute
      loop do
        nodes = {}
        service = client.get("services/#{current_grid}/#{name}")
        result = client.get("services/#{current_grid}/#{name}/containers")
        result['containers'].each do |container|
          nodes[container['node']['name']] ||= []
          nodes[container['node']['name']] << container
        end
        clear_terminal
        puts "service: #{name} (#{result['containers'].size}/#{service['container_count']} instances)"
        puts "strategy: #{service['strategy']}"
        puts "status: #{service['state']}"
        puts "stateful: #{service['stateful'] == true ? 'yes' : 'no' }"
        puts "nodes:"
        node_names = nodes.keys.sort
        node_names.each do |name|
          containers = nodes[name]
          puts "  #{name} (#{containers.size} instances)"
          print "  "
          containers.each do |container|
            color = container['status']
            if container['status'] == 'running'
              color = :green
            elsif container['status'] == 'killed'
              color = :red
            elsif container['status'] == 'stopped'
              color = :gray
            else
              color = :yellow
            end
            print "■".colorize(color)
          end
          puts ''
        end
        sleep interval.to_f
      end
    end

    def clear_terminal
      print "\e[H\e[2J"
    end
  end
end
