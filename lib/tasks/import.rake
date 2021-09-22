require 'managing_hotels/importing/importer'

namespace :hotels do
  desc "Imports all hotel information"
  task :import => :environment do
    ManagingHotels::Importing::Importer.new.call
  end
end
