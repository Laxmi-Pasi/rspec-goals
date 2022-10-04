require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:project_name) }
    it { should validate_presence_of(:project_status) }
  end

  describe 'enums' do
    it { should define_enum_for(:project_status).with(%i[open in_progress to_be_tested closed]) }
  end
end
