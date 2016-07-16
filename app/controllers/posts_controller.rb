class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params.require(:post).permit(:title, :author, :mood, :body))
    if @post.save
      redirect_to action: "index"
    else
      puts "ERROR"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(params.require(:post).permit(:title, :author, :mood, :body))
      redirect_to action: "index"
    else
      puts "ERROR"
    end
  end

end