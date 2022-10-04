class Project < ApplicationRecord
  belongs_to :user
  enum project_status: { 'open': 0, 'in_progress': 1, 'to_be_tested': 2, 'closed': 3 }

  validates :project_name, :project_status, presence: true
end
