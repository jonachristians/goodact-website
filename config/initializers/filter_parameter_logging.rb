# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
# you yould add :authentication_token, however it is not necessary
Rails.application.config.filter_parameters += [:password]
