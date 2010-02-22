namespace :pol do
  desc "Sync extra files from pol"
  task :sync do
    # sync migraitons and public folder
    system "rsync -ruv vendor/plugins/pol/db/migrate db"
    system "rsync -ruv vendor/plugins/pol/public public"
    system "rsync -ruv vendor/plugins/pol/vendor/plugins vendor"
  end
end