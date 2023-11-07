class Admin::NewsLettersController < ApplicationController
 def show
   @news_letter = NewsLetter.find(params[:id])
   
 end 
 
 def index
   @news_letters = NewsLetter.all
   @news_letter = NewsLetter.new
 end 
 
 def create
   @news_letter = NewsLetter.new(post_params)
   @news_letter.admin_id = current_admin.id
   if @news_letter.save
       redirect_to news_letter_path(@news_letter), notice: "You have created book successfully."
   else
     @news_letters = NewsLetter.all
     render 'index'
   end
 end 
 
 def edit
 end
 
 def update
   if @news_letter.update(news_letter_params)
     redirect_to news_letter_path(@news_letter), notice: "You have updated book successfully."
   else
     render "edit"
   end 
 end 
 
 def destroy
   @news_letter.destroy
   redirect_to news_letters_path
 end 
 
 private
 
 def post_params
   params.require(:post).permit(:title, :text)
 end
end
