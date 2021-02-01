class LikesController < ApplicationController
    before_action :authenticate_user!

    def create
        idea = Idea.find params[:idea_id]
        like = Like.new user: current_user, idea: idea
        if !can?(:like, idea)
            flash[:alert] = "You can't like your own idea"
        elsif like.save
            flash[:info] = "Idea Liked!"
            redirect_to like.idea
        else
            flash[:warning] = like.errors.full_messages.join(', ')
        end
    end

    def destroy
        like = Like.find params[:id]
        if can? :destroy, like
            like.destroy
            flash[:info] = "Unliked Idea"
            redirect_to like.idea
        else 
            flash[:alert] = "Could not like idea"
            redirect_to like.idea
        end
    end

end