class IdeasController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :find_idea, only: [:new, :show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new(idea_params)
    @idea.user = current_user

    if @idea.save
      # `question_path` is going the route to the question
      # `@question` by using its .id method.
      redirect_to idea_path(@idea.id)
    else
      render :index
    end
  end

  def show
    @reviews = @idea.reviews.order(created_at: :desc)

    # This will be for the form_for to create an answer for
    # @question.
    @review = Review.new
  end

  def index
    @idea = Idea.new
    @ideas = Idea.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @idea.update(idea_params)
      redirect_to idea_path(@idea)
    else
      render :edit
    end
  end

  def destroy
    @idea.destroy
    redirect_to ideas_path
  end

  private
  def idea_params
    params.require(:idea).permit(:title, :body)
  end

  def find_idea
    @idea = Idea.find(params[:id])
  end

  def authorize_user!
    unless can?(:manage, @idea)
      flash[:alert] = "Access Denied"
      redirect_to idea_path(@idea)
    end
  end
end
