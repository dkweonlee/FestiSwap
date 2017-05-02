class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :find_ad, only: %i[new show create edit destroy update]
  before_action :find_event, only: %i[show new create destroy edit update]
  before_action :find_user, only: %i[new create edit update destroy]
  before_action :find_comment, only: [:show, :edit, :update, :destroy]
  def new
    @comment = Comment.where(event: params[:event_id], ad: params[:ad_id]).new
  end

  def create
    @comment = Comment.where(event: params[:event_id], ad: params[:ad_id]).new comment_params
    if @comment.save
      redirect_to [@event, @ad], notice: "Awesome! You generated comment!"
    else
      render 'new', notice: "Oops, something went wrong! Sorry!"
    end
  end

  def edit
    if current_user.id == @comment.user_id
    else
      flash.now[:alert] = "Error, You are not an owner of this Comment"
      redirect_to [@event, @ad]
    end
  end

  def update
    if @comment.update comment_params
      redirect_to [@event, @ad], notice: "Your comment was sucessfully updated!"
    else
      render 'edit'
    end
  end

  def destroy
    if current_user.id == @comment.user_id
      @comment.destroy
      redirect_to [@event, @ad]
    else
      flash.now[:alert] = "Error, You are not an owner of this Comment"
      redirect_to [@event, @ad]
    end
  end

  private
    def find_event
      @event = Event.find(params[:event_id])
    rescue ActiveRecord::RecordNotFound
      render 'errors/not_found', status: :not_found
    end

    def find_ad
      @ad = Ad.find(params[:ad_id])
    end

    def find_user
      @user = current_user.id
    end

    def comment_params
      params.require(:comment).permit(:comment).merge(user_id: current_user.id)
    end

    def find_comment
      @comment = Comment.find(params[:id])
    end
end
