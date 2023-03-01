# frozen_string_literal: true

module V1
  # Base API class
  class API < Grape::API
    version 'v1', using: :path

    mount Weather
    mount Backend
  end
end
