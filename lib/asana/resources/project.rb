# frozen_string_literal: true

require_relative 'base'

module Asana
  module Resources
    class Project < Base
      def all
        client.get('/projects')
      end
    end
  end
end
