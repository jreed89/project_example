class CommentsController < ApplicationController
  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body, :author))
    @comment.post = @post
    if @comment.save
      redirect_to action: "index"
    else
      puts "ERROR"
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(params.require(:comment).permit(:body, :author))
      redirect_to action: "index"
    else
      puts "ERROR"
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to action: "index"
  end

end

## This can be cleaned up and refactored a bit.
## Rather than calling params.require(:comment).permit(:body, :author)
## all the time, we can define a method called `comment_params` to replace it,
## and then just invoke the method.
## Similarly, we can replace Comment.find(params[:id])
## and Post.find(params[:post_id]) with methods `set_comment` and `set_post`,
## respectfully. This is possible because @comment and @post are
## instance variables, which makes them accessible to all methods in the
## controller. These methods can then be set as ":before callbacks" on the
## controller methods where they are used, using the `before_action`
## helper method.


# class CommentsController < ApplicationController
#   before_action :set_post, only: [:index, :create]
#   before_action :set_comment, only: [:show, :edit, :update, :destroy]
#
#   def index
#     @comments = @post.comments
#   end
#
#   def show
#     @comment
#   end
#
#   def new
#     @comment = Comment.new
#   end
#
#   def create
#     @comment = Comment.new(comment_params)
#     @comment.post = @post
#     if @comment.save
#       redirect_to action: "index"
#     else
#       puts "ERROR"
#     end
#   end
#
#   def edit
#     @comment
#   end
#
#   def update
#     if @comment.update(comment_params)
#       redirect_to action: "index"
#     else
#       puts "ERROR"
#     end
#   end
#
#   def destroy
#     @comment.destroy
#     redirect_to action: "index"
#   end
#
#   private
#   def comment_params
#     params.require(:comment).permit(:body, :author)
#   end
#
#   def set_post
#     @post = Post.find(params[:post_id])
#   end
#
#   def set_comment
#     @comment = Comment.find(params[:id])
#   end
#
# end
