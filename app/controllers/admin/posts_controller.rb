class Admin::PostsController < ApplicationController
 def show
   @post = Post.find(params[:id])
 end 
 
 def edit
    @post = Post.find(params[:id])
 end
 
 def index
   @posts = Post.all
   @post = Post.new
   @customer = Customer.all
 end 
 
 def destroy
   post = Post.find(params[:id])
   post.destroy
   redirect_to admin_posts_path
 end 
 
 private
 
 def post_params
   params.require(:post).permit(:title, :text)
 end
 
end
