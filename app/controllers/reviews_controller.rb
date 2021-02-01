class ReviewsController < ApplicationController
    before_action :authenticate_user!
    before_action :load_review!, only: [:destroy]
    before_action :authorize_user!, only: [:destroy]
  
    def create
      @idea = Idea.find params[:idea_id]
      @review = Review.new params.require(:review).permit(:rating, :body)
      @review.idea = @idea
      @review.user = @current_user
      
      if @review.save
        redirect_to idea_path(@idea), notice: "Review created successfully."
      else
        render 'ideas/show'
      end
    end
    
    def destroy
      @review.destroy
      redirect_to idea_path(@review.idea), notice: "Review deleted successfully."
    end
  
    private
  
    def load_review!
      if params[:id].present?
        @review = Review.find params[:id]
      else
        @review = Review.new
      end
    end
  
    def authorize_user!
      unless can? :crud, @review
        flash[:danger] = "Acess Denied"
        redirect_to root_path
      end
    end
  end