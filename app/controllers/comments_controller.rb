class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, only: [:edit, :update, :destroy]

  def index
    @comments = Comment.all
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
        render :edit
      end
      flash[:alert] = お前本人じゃない
      redirect_to @commentable
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
    @commentable = Book.find(params[:book_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end