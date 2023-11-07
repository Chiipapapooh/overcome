class Admin::PostsController < ApplicationController
 def show
   @post = Post.find(params[:id])
 end 
 
 def index
   @posts = Post.all
   @post = Post.new
 end 
 
 def destroy
   @post.destroy
   redirect_to posts_path
 end 
 
 private
 
 def post_params
   params.require(:post).permit(:title, :text)
 end
 
end
