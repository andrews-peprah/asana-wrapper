require_relative '../../lib/asana'
require 'vcr'
require 'webmock/rspec'
require 'json'

RSpec.describe Asana::Client do
  let(:personal_access_token) { ENV.fetch('ASANA_PERSONAL_ACCESS_TOKEN', '') }
  let(:client) { described_class.new(personal_access_token: personal_access_token) }

  describe '#projects' do
    it 'returns a list of projects' do
      VCR.use_cassette('asana_projects') do
        projects = client.projects.all
        expect(projects).not_to be_empty
        expect(projects).to include('data' => an_instance_of(Array))
      end
    end
  end

  describe '#sections' do
    let(:projects) { client.projects.all }
    let(:project_gid) { projects['data'].first['gid'] }

    it 'returns a list of sections in a project' do
      VCR.use_cassette('asana_sections') do
        sections = client.sections.all(project_gid: project_gid)
        expect(sections).not_to be_empty
        expect(sections).to include('data' => an_instance_of(Array))
      end
    end

    it 'returns a specific section by id' do
      VCR.use_cassette('asana_section') do
        sections = client.sections.all(project_gid: project_gid)
        section_gid = sections['data'].first['gid']
        section = client.sections.find(section_gid: section_gid)
        expect(section).not_to be_nil
        expect(section).to include('data' => an_instance_of(Hash))
      end
    end
  end
end
