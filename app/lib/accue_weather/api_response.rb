# frozen_string_literal: true

module AccueWeather
  # Api response from AccueWeather
  class APIResponse
    include ApplicationHelper

    attr_accessor :response

    def initialize(response)
      @response = response
    end

    def uniq_id
      @uniq_id ||= get_nested_value(response, 'Key')
    end

    def weather_text
      @weather_text ||= get_nested_value(response, 'WeatherText')
    end

    def temperature
      @temperature ||= get_nested_value(response, 'Metric')
    end

    def temperature_24_hour
      hash = {}

      response[:body].each_with_index do |v, _|
        key = Time.at(v['EpochTime']).to_datetime

        hash[key] = v['Temperature']['Metric'] if hash[key].blank?

        hash[key].merge!(weather_text: weather_text)
      end

      hash
    end

    def max_temp_in_24_hour
      temperature_24_hour.values.map { |x| x['Value'] }.max
    end

    def min_temp_in_24_hour
      temperature_24_hour.values.map { |x| x['Value'] }.min
    end

    def avg_temp_in_24_hour
      array = []

      temperature_24_hour.each_value do |x|
        array << x['Value']
      end

      (array.instance_eval { reduce(:+) / size.to_f }).round(2)
    end

    def closet_temperature(all_temp, timestamp)
      # I did this, because I have an email from a support team from AccueWeather
      # where they saying they don't have search support via timestamp

      all_temp.key?(timestamp)
    end
  end
end
