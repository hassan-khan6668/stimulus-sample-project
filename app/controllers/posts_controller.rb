class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.all
  end

  # POST /posts
  def create
    @post = Post.new(post_params)  # post_params is used here
    if @post.save
      respond_to do |format|
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/:id
def update
  if @post.update(post_params)
    respond_to do |format|
      format.html { redirect_to @post, notice: "Post was successfully updated." }
      format.turbo_stream
    end
  else
    render :edit, status: :unprocessable_entity
  end
end

  # DELETE /posts/:id
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.turbo_stream
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)  # post_params is defined here
  end
end
