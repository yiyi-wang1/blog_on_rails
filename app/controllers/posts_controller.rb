class PostsController < ApplicationController
    before_action :find_post, only: [:show, :edit, :update, :destroy]

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(get_params)
        if @post.save
            flash[:notice] = "Post created successfully."
            redirect_to post_path(@post)
        else
            render "/posts/new", status: 303
        end
    end

    def index
        @posts = Post.order(created_at: :desc)

    end

    def show
        @comments = @post.comments.order(created_at: :desc)
        @comment = Comment.new
    end

    def edit

    end

    def update
        if @post.update(get_params)
            flash[:notice] = "Post updated successfully."
            redirect_to post_path(@post)
        else
            render :edit
        end
    end

    def destroy
        if @post.destroy
            flash[:notice] = "Post deleted successfully."
            redirect_to posts_path
        else
            flash[:alert] = "Cannot delete post!"
        end
    end

    def find_post
        @post = Post.find(params[:id])
    end
    
    def get_params
        params.require(:post).permit(:title, :body)
    end
end
