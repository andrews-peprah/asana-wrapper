# frozen_string_literal: true

require_relative 'base'

module Asana
  module Resources
    class Section < Base
      def all(project_gid:)
        client.get("/projects/#{project_gid}/sections")
      end

      def find(section_gid:)
        client.get("/sections/#{section_gid}")
      end
    end
  end
end
