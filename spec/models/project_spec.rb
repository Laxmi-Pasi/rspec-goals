require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:project_name) }
    it { should validate_presence_of(:project_status) }
  end

  describe 'enums' do
    it { should define_enum_for(:project_status).with(%i[open in_progress to_be_tested closed]) }
  end

  describe 'associations' do
    it { should belong_to(:user) } 
  end
end
