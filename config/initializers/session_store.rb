# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_classroom_session',
  :secret      => '9653f1293d7d538166534650ef3b406bab2a55770f3ac9f38ad218a83f5af04085fafd69a7ceaafa332caa046f468bb67ebf26f49f5838c369398da70ec62d93'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
