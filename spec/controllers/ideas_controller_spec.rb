require 'rails_helper'

RSpec.describe IdeasController, type: :controller do

  def current_user
    @current_user ||= FactoryBot.create(:user)
  end

  describe "#new" do

    context "without a logged in user" do
      it "redirects to the login page" do
        get :new

        expect(response).to redirect_to(new_session_path)
      end
    end

    context "with a user logged in" do
      before do
        session[:user_id] = current_user.id
      end

      it "render the new idea form" do 
        get :new

        expect(response).to render_template(:new)
      end

      it "creates an instance varible of a new idea" do 
        get :new

        expect(assigns(:idea)).to be_a_new(Idea)
      end
    end
  end

  describe "#create" do
    def valid_request
      post(:create, params: { idea: FactoryBot.attributes_for(:idea)})
    end

    context "without a logged in user" do
      it "redirects to the login page" do 
        valid_request
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "with a user logged in" do
      before do
        session[:user_id] = current_user.id
      end
      
      context "with valid params" do
        it "assigns an valid product to an instance variable" do
          valid_request
          idea = assigns(:idea)

          expect(idea).to be_a(Idea)
          expect(idea.valid?).to eq(false)
        end

        it "creates an idea and saves it to the database" do
          count_before = Idea.count
          valid_request

          count_after = Idea.count
          expect(count_before).to eq(count_after)
        end
      end

      context "with invalid params" do
        def invalid_request
          post(
            :create, 
            params: { idea: FactoryBot.attributes_for(:idea, title: nil)}
          )
        end

        it "doesn't create a new idea in our db" do
          count_before = Idea.count
          invalid_request
          count_after = Idea.count

          expect(count_after).to eq(count_before)
        end

        it "renders the new idea form" do
          invalid_request

          expect(response).to render_template(:new)
        end

        it "assigns an invalid idea to an instance variable" do
          invalid_request
          idea = assigns(:idea)

          expect(idea).to be_a(Idea)
          expect(idea.valid?).to eq(false)
        end
      end
  
      context 'with invalid parameters' do
        def invalid_request
          post :create, params: {
            idea: FactoryBot.attributes_for(:idea, title: nil)
          }
        end
  
        it 'doesn\'t save an idea to the db' do
          count_before = Idea.count
          invalid_request
          count_after = Idea.count
          expect(count_after).to eq(count_before)
        end
  
        it 'render the new template' do
          invalid_request
          expect(response).to render_template(:new)
        end    
      end
    end
  end
end