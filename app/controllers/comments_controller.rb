class CommentsController < ApplicationController
  
before_filter :load_commentable
before_filter :init
  
  def index
    @comments = @commentable.comments
  end

  def new
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new(params[:comment])
    @comment.user = current_user
    
    if @comment.save
      flash[:success] = 'Comment created'
      redirect_to @commentable
    else
      flash[:error] = 'Comment not created - is body empty?'
      redirect_to @commentable
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = "Comment Deleted"
    redirect_to @commentable
  end

private

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end

  def init
    @resource, @id = request.path.split('/')[1, 2]

  end
  # def load_commentable
  #   klass = [Article, Photo, Event].detect { |c| params["#{c.name.underscore}_id"] }
  #   @commentable = klass.find(params["#{klass.name.underscore}_id"])
  # end
  
#ORIGINAL--
#  def create
#      @post = Post.find(params[:post_id])
#      @comment = @post.comments.create(params[:comment])
#      #@comment = current_user.comments.create(params[:comment])
#      
#      redirect_to post_path(@post)
#    end
#
#  def destroy
#    @post = Post.find(params[:post_id])
#    @comment = @post.comments.find(params[:id])
#    @comment.destroy
#    redirect_to post_path(@post)
#  end



end
