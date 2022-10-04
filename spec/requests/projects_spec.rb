require 'rails_helper'

RSpec.describe 'Projects', type: :request do
  include Devise::Test::IntegrationHelpers

  context "when user is not logged in" do
    it 'before action authenticate user' do
      get projects_url
      expect(response).to redirect_to('/users/sign_in')
    end
  end

  context "when user is logged in" do
    before do
      @user = create(:user)
      @project = create(:project, user_id: @user.id)
      sign_in(@user)
    end

    describe 'GET /index' do
      it 'returns http success' do
        get projects_path
        expect(response).to have_http_status(:success)
      end
    end
  
    describe 'GET /new' do
      it 'returns http success' do
        get new_project_path
        expect(response).to have_http_status(:success)
      end
    end
  
    describe 'POST /create' do
      context 'with valid params' do
        it 'project successfully created and redirect to projects_url' do
          expect do
            post projects_path, params: { project: { project_name: 'loconav', project_status: 'open' , user_id: @user.id} }
          end.to change(Project, :count).by(1)
          expect(response).to redirect_to(projects_url)  
        end
      end
      
      context 'with invalid params' do
        it 'fails at creating project and render to new' do
          expect do
            post projects_path, params: { project: { project_name: '', project_status: '' } }
          end.to change(Project, :count).by(0)
          expect(response).to have_http_status(:unprocessable_entity) # 422 Unprocessable entity
          expect(response).to render_template('new') 
        end
      end
    end
  
    describe 'GET /projects/id/edit' do
      it 'returns http success' do
        get edit_project_path(@project.id)
        expect(response).to have_http_status(:success)
      end
    end
  
    describe 'Patch /projects/id/update' do
      context 'valid params' do
        it 'project successfully updated and redirect to projects_url' do    
          patch project_path(@project.id),params: { project: { project_name: 'CISM', project_status: 'closed' } }
          expect(response).to redirect_to(projects_url)
        end
      end
  
      context 'invalid params' do
        it 'fails at updating project and render edit ' do
          patch project_path(@project.id), params: { project: { project_name: '', project_status: '' } }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response).to render_template('edit') 
        end
      end
    end
  
    describe 'DELETE /projects/id/destroy' do
      it 'succeeds' do
        delete project_path(@project.id)
        expect(response).to redirect_to(projects_url)
      end
    end

    context "when project is not created by current user" do
      before do
        @project = create(:project)
      end
  
      describe 'GET /projects/id/edit' do
        it 'should redirect to root path' do
          get edit_project_path(@project.id)
          expect(response).to redirect_to(root_path)
        end
      end
  
      describe 'DELETE /projects/id/destroy' do
        it 'should redirect to root path' do
          delete project_path(@project.id)
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end

end
