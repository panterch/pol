# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_pol3_session',
  :secret => '3189cb60bff7264ed8df0a94d037e89d2605af3889f35dc55e6c6d5d0c8e2c96d29891f4c0952ea6fbdde35c4cc859c84937c1c539df3db09f9af7bb1b83be6d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
