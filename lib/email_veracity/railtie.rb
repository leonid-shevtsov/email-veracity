class EmailVeracityRailtie < Rails::Railtie
  config.i18n.load_path += Dir[File.join(File.dirname(__FILE__), 'locale', '*.{rb,yml}').to_s]
end
