# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_tweet_room_session',
  :secret      => 'ad4a313f8b2bc17add83a96003f915a8e6a4275e54556bccf52aec6f8c51f9f633bf4626bdd561abbc8d511c625d7b88b4dff3f0940732c6296cf0a1ddca9299'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
