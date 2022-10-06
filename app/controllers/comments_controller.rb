class CommentsController < ApplicationController
  before_action :set_article
  before_action :set_article_comment, only: [:show, :update, :destroy]

  # GET /articles/:todo_id/comments
  def index
    json_success(@article.comments)
  end

  # GET /articles/:article_id/comments/:id
  def show
    json_success(@comment)
  end

  # POST /articles/:article_id/comments
  def create
    @article.comments.create!(comment_params)
    json_create_success(@article)
  end

  # PUT /articles/:article_id/comments/:id
  def update
    @comment.update(comment_params)
    head :no_content
  end

  # DELETE /articles/:article_id/comments/:id
  def destroy
    @comment.destroy
    head :no_content
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_article_comment
    @comment = @article.comments.find_by!(id: params[:id]) if @article
  end
end
