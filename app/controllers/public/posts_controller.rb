class Public::PostsController < ApplicationController
 def show
   @post = Post.find(params[:id])
   
 end 
 
 def index
   @posts = Post.all
   @post = Post.new
 end 
 
 def create
   @post = Post.new(post_params)
   @post.customer_id = current_customer.id
   if @post.save
       redirect_to post_path(@post), notice: "You have created book successfully."
   else
     @posts = Post.all
     render 'index'
   end
 end 
 
 def edit
 end
 
 def update
   if @post.update(post_params)
     redirect_to post_path(@post), notice: "You have updated book successfully."
   else
     render "edit"
   end 
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