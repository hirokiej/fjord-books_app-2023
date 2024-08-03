# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, only: [:edit, :update, :destroy]

  def index
    @comments = Comment.order(:id)
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @commentable, notice: 'Comment was succsessfully created'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @comment.user == current_user
      if @comment.update(comment_params)
        redirect_to @commentable
      else
        redirect_to @commentable
        flash[:alert] = "編集できません"
      end
    else
      redirect_to @commentable
      flash[:alert] = "あなた本人違う"
    end
  end

  def destroy
    if @comment.user == current_user
      @comment.destroy
    else
      flash[:alert] = "消せません"
    end
    redirect_to @commentable
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_commentable
    if params[:book_id]
      @commentable = Book.find(params[:book_id])
    else params[:report_id]
      @commentable = Report.find(params[:report_id])
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
