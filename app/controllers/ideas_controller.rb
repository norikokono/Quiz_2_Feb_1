class IdeasController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_idea!, except: [:create]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

    def index
      @ideas = Idea.all.order(created_at: :DESC)
      @like = @idea.likes.find_by(user: current_user)
      @join = @idea.joins.find_by(user: current_user)
    end

    def new
      @idea = Idea.new
    end

    def create
      @idea = Idea.new idea_params
      @idea.user = @current_user
      if @idea.save
        redirect_to @idea, notice: "Created New Idea!"
      else
        render :new
      end
    end

    def show
      @idea = Idea.find(params[:id])
      @review = Review.new
    end

    def edit
      @idea = Idea.find(params[:id])
    end

    def update
      @idea = Idea.find params[:id]
      if @idea.update idea_params
        redirect_to idea_path(@idea), notice: "Idea edited successfully."
      else
        render :edit
      end
    end


    def destroy
      @idea = Idea.find(params[:id])
      @idea.destroy
      redirect_to ideas_path, notice: "Idea deleted successfully."
    end

    private

    def idea_params
      params.require(:idea).permit(:title, :description)
    end

    def load_idea!
      if params[:id].present?
        @idea = Idea.find (params[:id])
      else
        @idea = Idea.new
      end
    end

    def authorize_user!
      unless can? :crud, @idea
        flash[:danger] = "Access Denied"
        redirect_to root_path
    end
  end
end