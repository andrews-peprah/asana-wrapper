require_relative 'lib/asana'

client = Asana::Client.new(personal_access_token: ENV.fetch('ASANA_PERSONAL_ACCESS_TOKEN', ''))

# Get project
projects = client.projects.all
pp projects

# Get sections in project
sections = client.sections.all(project_gid: projects['data'].first['gid'])
pp "Sections: #{sections}"

# Get section by id
section = client.sections.find(section_gid: sections['data'].first['gid'])
pp "Section: #{section}"
