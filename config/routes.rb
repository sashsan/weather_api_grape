# frozen_string_literal: true

Rails.application.routes.draw do
  mount RootAPI, at: '/'
  Rails.application.routes.default_url_options[:host] = ENV.fetch('HOST')

  root 'weather_infos#index'
end
