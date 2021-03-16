class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :youtube_post, only: :update
  before_action :set_q, only: [:index, :search]

  def index
    @posts = Post.includes(:user).order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    # beforeアクションでまとめるとエラーになるため記述
    url = params[:post][:youtube_url]
    url = url.last(11)
    @post.youtube_url = url
    # //beforeアクションでまとめるとエラーになるため記述
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  def search
    @results = @q.result
  end

  private

  def post_params
    params.require(:post).permit(:title, :youtube_url, :text).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def youtube_post
    url = params[:post][:youtube_url]
    url = url.last(11)
    @post.youtube_url = url
  end

  def set_q
    @q = Post.ransack(params[:q])
  end
end
