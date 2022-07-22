class CommentsController < ApplicationController
    before_action :find_post

    def create
        @comment = Comment.new(params.require(:comment).permit(:body))
        @comment.post = @post

        if @comment.save
            flash[:notice] = "Comment created successfully!"
            redirect_to post_path(@post)
        else
            flash[:alert] = "Cannot create comment!"
            @comments = @post.comments.order(created_at: :desc)
            render "/posts/show", status: 303
        end
        
    end

    def destroy
        @comment = Comment.find(params[:id])

        if @comment.destroy
            flash[:notice] = "Comment deleted successfully!"
        else
            flash[:alert] = "Cannot deleted comment!"
        end
        redirect_to post_path(@post)
    end

    private

    def find_post
        @post = Post.find(params[:post_id])
    end

end
