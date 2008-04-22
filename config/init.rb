# Make the app's "gems" directory a place where gems are loaded from
Gem.clear_paths
Gem.path.unshift(Merb.root / "gems")

# Make the app's "lib" directory a place where ruby files get "require"d from
$LOAD_PATH.unshift(Merb.root / "lib")


Merb::Config.use do |c|
  c[:session_id_key] = 'pmpknpi_session_id'
  c[:session_secret_key]  = '669bed3f14d49f3bfa52530312c225f3753455e1'
  c[:session_store] = 'cookie'
end  

### ORM
use_orm :activerecord

### Test framework the generators will use
use_test :rspec

### Requrements
require 'authenticated_system'
require 'date_and_time_helpers'
require 'global_mixin'
require 'BlueCloth'
require 'RedCloth'
require 'whistler'

### Dependencies
dependencies  "rubygems",
              "coderay",
              "merb_helpers",
              "merb-assets",
              "merb_can_filter"

# FROM merb_has_rails_plugins
Merb::BootLoader.before_app_loads do
  if defined?(Merb::Plugins)
    Dir["#{Merb.root}/plugins/*"].each do |dir|
      plugin_init = dir / 'init.rb'
       plugin_lib  = dir / 'lib' 

       if File.directory?(plugin_lib) 
         if defined?(ActiveSupport) 
           Dependencies.load_paths << plugin_lib 
           Dependencies.load_once_paths << plugin_lib 
        end
        $LOAD_PATH << plugin_lib
      end
      require plugin_init if File.exist?(plugin_init)
    end
  end
end

Merb::BootLoader.after_app_loads do
  ActiveRecord::Base.default_timezone = :utc
end

# YAML FILES
SETTINGS = YAML.load_file("#{Merb.root}/config/settings.yml")[Merb.environment]

# MIME TYPES
Merb.add_mime_type(:rss,  :to_xml,  %w[application/rss+xml])
Merb.add_mime_type(:atom, :to_atom, %w[application/atom+xml])
