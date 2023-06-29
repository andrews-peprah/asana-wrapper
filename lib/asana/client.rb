# frozen_string_literal: true

require_relative 'http_client'

module Asana
  class Client
    attr_reader :http_client

    # Public: Returns a new client instance.
    def initialize(personal_access_token:)
      @http_client = Asana::HttpClient.new(personal_access_token: personal_access_token)
    end

    # Public: Returns the {Asana::Resources::Project} resource.
    #
    # Examples
    # client.projects.all
    def projects
      Asana::Resources::Project.new(client: http_client)
    end

    # Public: Returns the {Asana::Resources::Section} resource.
    #
    # Examples
    # client.sections.find(section_gid: 123)
    def sections
      Asana::Resources::Section.new(client: http_client)
    end

    # Public: Returns the {Asana::Resources::Task} resource.
    #
    # Examples
    # client.tasks.update(task_gid: 123, data: { name: 'New name' })
    def tasks
      Asana::Resources::Task.new(client: http_client)
    end
  end
end
