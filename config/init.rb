# Make the app's "gems" directory a place where gems are loaded from
Gem.clear_paths
Gem.path.unshift(Merb.root / "gems")

# Make the app's "lib" directory a place where ruby files get "require"d from
$LOAD_PATH.unshift(Merb.root / "lib")


Merb::Config.use do |c|
  ### Sets up a custom session id key, if you want to piggyback sessions of other applications
  ### with the cookie session store. If not specified, defaults to '_session_id'.
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
require 'active_record_extension'
require 'BlueCloth'
require 'RedCloth'

### Dependencies
dependencies  "rubygems",
              "coderay",
              "merb_helpers",
              "merb-assets",
              "merb_can_filter"

### Add your other dependencies here

# These are some examples of how you might specify dependencies.
# 
# dependencies "RedCloth", "merb_helpers"
# OR
# dependency "RedCloth", "> 3.0"
# OR
# dependencies "RedCloth" => "> 3.0", "ruby-aes-cext" => "= 1.0"

Merb::BootLoader.after_app_loads do
  ### Add dependencies here that must load after the application loads:
  # dependency "magic_admin" # this gem uses the app's model classes
end

# YAML FILES
SETTINGS = YAML.load_file("#{Merb.root}/config/settings.yml")[Merb.environment]

# MIME TYPES
Merb.add_mime_type(:rss, :to_xml, %w[application/rss+xml])
