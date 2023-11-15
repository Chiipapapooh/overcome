class Admin::NewsLettersController < ApplicationController
 def show
   @news_letter = NewsLetter.find(params[:id])
 end 
 
 def index
   @news_letters = NewsLetter.all
   @news_letter = NewsLetter.new
 end 
 
 def new
   @news_letter = NewsLetter.new
   @genres = Genre.all
   @genre = Genre.new
 end 
 
 def create
   @news_letter_new = NewsLetter.new(news_letter_params)
   if params[:publicize_draft]
    @news_letter_new.is_draft = false
    if @news_letter_new.save
       redirect_to admin_news_letter_path(@news_letter_new), notice: "投稿を保存しました！"
    else
       redirect_to admin_news_letters_path, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
    end
   else
    if @news_letter_new.update(is_draft: true)
       redirect_to admin_news_letter_path, notice: "下書き保存しました！"
    else
       redirect_to admin_news_letters_path, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
    end
   end
 end
 
 def edit
    @news_letter = NewsLetter.find(params[:id])
 end
 
 def update
    @news_letter = NewsLetter.find(params[:id])
    if params[:publicize_draft]
      @news_letter.attributes = news_letter_params.merge(is_draft: false)
      if @news_letter.save(context: :publicize)
        redirect_to admin_news_letter_path(@news_letter), notice: "下書きを公開しました！"
      else
        @news_letter.is_draft = true
        render :edit, alert: "投稿を公開できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    elsif params[:update_news_letter]
      @news_letter.attributes = news_letter_params
      if @post.save(context: :publicize)
        redirect_to news_letter_path(@news_letter), notice: "投稿を更新しました！"
      else
        render :edit, alert: "投稿を更新できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    else
      if @pnews_letter.update(news_letter_params)
        redirect_to news_letter_path(@news_letter), notice: "下書きを更新しました！"
      else
        render :edit, alert: "更新できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    end
 end 
 
 def destroy
   news_letter = NewsLetter.find(params[:id])
   news_letter.destroy
   redirect_to admin_news_letters_path
 end 
 
 private
 
 def news_letter_params
   params.require(:news_letter).permit(:news_title, :news_text, :image, :genre_id)
 end
end
