require 'deface'

module ForemanMonitoring
  class Engine < ::Rails::Engine

    config.autoload_paths += Dir["#{config.root}/app/controllers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/helpers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/overrides"]

    # Add any db migrations
    initializer "foreman_monitoring.load_app_instance_data" do |app|
      app.config.paths['db/migrate'] += ForemanMonitoring::Engine.paths['db/migrate'].existent
    end

    initializer 'foreman_monitoring.register_plugin', :after=> :finisher_hook do |app|
      Foreman::Plugin.register :foreman_monitoring do
        requires_foreman '>= 1.4'

        # Add permissions
        security_block :foreman_monitoring do
          permission :view_foreman_monitoring, {:'foreman_monitoring/hosts' => [:new_action] }
        end

        # Add a new role called 'Discovery' if it doesn't exist
        role "ForemanMonitoring", [:view_foreman_monitoring]

      end
    end

    #Include concerns in this config.to_prepare block
    config.to_prepare do
      begin
        Host::Managed.send(:include, ForemanMonitoring::HostExtensions)
        HostsHelper.send(:include, ForemanMonitoring::HostsHelperExtensions)
      rescue => e
        puts "ForemanMonitoring: skipping engine hook (#{e.to_s})"
      end
    end

    rake_tasks do
      Rake::Task['db:seed'].enhance do
        ForemanMonitoring::Engine.load_seed
      end
    end

  end
end
