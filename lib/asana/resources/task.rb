# frozen_string_literal: true

module Asana
  module Resources
    class Task
      def update(task_gid:, data: {})
        client.put("/tasks/#{task_gid}", data: data)
      end
    end
  end
end
