require_relative 'lib/asana'

client = Asana::Client.new(personal_access_token: '1/8253796198094:49595a715371e561e8980e052543531d')

# Get project
projects = client.projects.all

# Get sections in project
sections = client.sections.all(project_gid: projects['data'].first['gid'])
pp "Sections: #{sections}"

# Get section by id
section = client.sections.find(section_gid: sections['data'].first['gid'])
pp "Section: #{section}"
