# frozen_string_literal: true

require 'grape-swagger'


# Root API class
class RootAPI < Grape::API
  format :json
  prefix :api

  helpers do
    def permitted_params
      @permitted_params ||= declared(params, include_missing: false)
    end
  end

  rescue_from NameError, with: -> { error! 'undefined local variable or method', 400 }

  mount ::V1::API

  add_swagger_documentation \
    host: ENV.fetch('SWAGGER_HOST'),
    doc_version: '0.0.1',
    base_path: '',
    mount_path: '/v1/docs',
    add_base_path: true,
    add_version: true,
    info: {
      title: 'Weather API',
      contact_url: 'https://localhost'
    },
    array_use_braces: true
end
