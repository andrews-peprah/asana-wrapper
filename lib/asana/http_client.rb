# frozen_string_literal: true

# 1/8253796198094:49595a715371e561e8980e052543531d

require 'net/http'
require 'json'

module Asana
  class HttpClient
    attr_reader :access_token

    BASE_URI = 'https://app.asana.com/api/1.0'

    def initialize(personal_access_token:)
      @access_token = personal_access_token
    end

    def get(url, query_params = {})
      request('get', url, query_params: query_params)
    end

    def post(url, data = {})
      request('post', url, data: data)
    end

    def put(url, data = {})
      request('put', url, data: data)
    end

    private

    def request(method, url, data: {}, query_params: {})
      url = "#{BASE_URI}#{url}".gsub(%r{([^:])//}, '\1/')
      uri = URI(url)
      uri.query = URI.encode_www_form(query_params) unless query_params.empty?

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP.const_get(method.capitalize).new(uri)
      headers.each { |key, value| request[key] = value }
      request.body = data.to_json unless data.empty?

      response = http.request(request)
      case response
      when Net::HTTPSuccess
        JSON.parse(response.body)
      when Net::HTTPBadRequest
        raise "Bad request: #{response.body}"
      when Net::HTTPUnauthorized
        raise "Unauthorized: #{response.body}"
      when Net::HTTPNotFound
        raise "Not found: #{response.body}"
      when Net::HTTPServerError
        raise "Server error: #{response.body}"
      when Net::HTTPClientError
        raise "Client error: #{response.body}"
      when Net::HTTPRedirection
        raise "Redirection: #{response.body}"
      when Net::HTTPForbidden
        raise "Forbidden: #{response.body}"
      else
        response.value
      end
    end

    def headers
      {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json',
        'Authorization' => "Bearer #{access_token}",
        'User-Agent' => 'Asana Ruby Client/0.0.1',
        'X-Asana-Client-Lib' => 'ruby-asana',
        'X-Asana-Client-Lib-Version' => '0.0.1',
        'X-Asana-Client-Name' => 'ruby-asana',
        'X-Asana-Client-Version' => '0.0.1'
      }
    end
  end
end
