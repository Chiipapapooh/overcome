class Public::NewsLettersController < ApplicationController
 def show
   @news_letter = NewsLetter.find(params[:id])
   @genres = Genre.all
 end 
 
 def index
   @genres = Genre.all
   @news_letter = NewsLetter.new
   if params[:genre_id].present?
       genre_id = params[:genre_id]
       @genre = Genre.find(genre_id)
       @news_letters = NewsLetter.all.where(genre_id: genre_id)
   else
       @news_letters = NewsLetter.all
   end
 end 
 
 def destroy
   @news_letter.destroy
   redirect_to news_letters_path
 end 
 
 private
 
 def post_params
   params.require(:news_letter).permit(:news_title, :news_text, :image)
 end
end
