class JoinsController < ApplicationController
    before_action :authenticate_user!
  
    def create
        idea = Idea.find params[:idea_id]
        join = Join.new user: current_user, idea: idea
        if !can?(:join, idea)
            flash[:alert] = "You can't join in your own idea"
        elsif join.save
            flash[:info] = "You joined!"
            redirect_to join.idea
        else
            flash[:warning] = join.errors.full_messages.join(', ')
        end
    end
  
    def destroy
        join = Join.find params[:id]
        if can? :destroy, join
            join.destroy
            flash[:info] = "Unjoined Idea"
            redirect_to join.idea
        else 
            flash[:alert] = "Could not join in idea"
            redirect_to join.idea
        end
    end
  
  end