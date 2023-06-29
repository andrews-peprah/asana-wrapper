# frozen_string_literal: true

module Asana
  module Resources
    class Task < Base
      def all(project_gid:)
        client.get("/projects/#{project_gid}/tasks")
      end

      def create(data: {})
        client.post('/tasks', data: data)
      end

      def update(task_gid:, data: {})
        client.put("/tasks/#{task_gid}", data: data)
      end
    end
  end
end
