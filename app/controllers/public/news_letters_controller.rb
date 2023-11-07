class Public::NewsLettersController < ApplicationController
 def show
   @news_letter = NewsLetter.find(params[:id])
 end 
 
 def index
   @news_letters = NewsLetter.all
   @news_letter = NewsLetter.new
 end 
 
 def destroy
   @news_letter.destroy
   redirect_to news_letters_path
 end 
 
 private
 
 def post_params
   params.require(:news_letter).permit(:news_title, :news_text)
 end
end
