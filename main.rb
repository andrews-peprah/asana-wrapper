require_relative 'lib/asana'

client = Asana::Client.new(personal_access_token: ENV.fetch('ASANA_PERSONAL_ACCESS_TOKEN', ''))

# Get project
projects = client.projects.all
pp projects

# Get sections in project
sections = client.sections.all(project_gid: projects['data'].first['gid'])
pp "Sections"
pp sections

# Get section by id
section = client.sections.find(section_gid: sections['data'].first['gid'])
pp "Section"
pp section

# Get all tasks
tasks = client.tasks.all(project_gid: projects['data'].first['gid'])
pp "Tasks"
pp tasks

# Update a task
result = client.tasks.update(task_gid: 1201983615356118, data: {name: 'Blogfeeder.'})
pp result
