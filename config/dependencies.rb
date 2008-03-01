# Make the app's "gems" directory a place where gems are loaded from
Gem.clear_paths
Gem.path.unshift(Merb.root / "gems")

# Make the app's "lib" directory a place where ruby files get "require"d from
$LOAD_PATH.unshift(Merb.root / "lib")

### ORM
use_orm :activerecord

### Test framework the generators will use
use_test :rspec

### Requrements
require 'authenticated_system'
require 'active_record_extension'
require 'date_and_time_helpers'
require 'global_mixin'

### Dependencies
dependencies  "rubygems",
              "RedCloth",
              "BlueCloth",
              "coderay",
              "merb_helpers"

Merb::BootLoader.after_app_loads do
  ### Add dependencies here that must load after the application loads:
  # dependency "magic_admin" # this gem uses the app's model classes
end

# YAML FILES
SETTINGS = YAML.load_file("#{Merb.root}/config/settings.yml")[Merb.environment].symbolize_keys
