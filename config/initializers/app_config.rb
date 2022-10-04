# frozen_string_literal: true

Rails.application.configure do
  config.before_initialize do
    APP_CONFIG = config_for(:app_config)
  end
end