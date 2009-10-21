namespace :pol do
  desc "Sync extra files from pol"
  task :sync do
    system "rsync -ruv vendor/plugins/pol/db/migrate db"
  end
end