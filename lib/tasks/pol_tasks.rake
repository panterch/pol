namespace :pol do
  desc "Sync extra files from pol"
  task :sync do
    system "rsync -ruv vendor/plugins/pol3/db/migrate db"
    system "rsync -ruv vendor/plugins/pol3/public public"
  end
end