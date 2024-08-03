# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, only: %i[edit update destroy]

  def index
    @comments = Comment.order(:id)
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @comment.user == current_user
      if @comment.update(comment_params)
        redirect_to @commentable, notice: t('controllers.common.notice_update', name: Comment.model_name.human)
      else
        redirect_to @commentable, alert: t('controllers.common.alert_update', name: Comment.model_name.human)
      end
    else
      redirect_to @commentable, alert: t('controllers.common.alert_authorized', name: Comment.model_name.human)
    end
  end

  def destroy
    if @comment.user == current_user
      @comment.destroy
      redirect_to @commentable, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
    else
      redirect_to @commentable, alert: t('controllers.common.alert_destroy', name: Comment.model_name.human)
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_commentable
    @commentable = params[:book_id] ? Book.find(params[:book_id]) : Report.find(params[:report_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
