class Public::PostsController < ApplicationController
 def show
   @post = Post.find(params[:id])
   @post_comment = PostComment.new
   @tags = @post.tag_counts_on(:tags)
 end 
 
 def index
   @posts = Post.where(is_draft: false)
   @post = Post.new
   @customer = Customer.all
 end 
 
 def new
   @post = Post.new
   @customer = current_customer
 end 
 
 def create
   @post_new = Post.new(post_params)
   @post_new.customer_id = current_customer.id
   if params[:publicize_draft]
    @post_new.is_draft = false
    if @post_new.save!
       redirect_to post_path(@post_new), notice: "投稿を保存しました！"
    else
       redirect_to posts_path, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
    end
   else
    if @post_new.update(is_draft: true)
       redirect_to mypage_path(current_customer), notice: "下書き保存しました！"
    else
       redirect_to posts_path, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
    end
   end
 end
 
 def edit
    @post = Post.find(params[:id])
    @customer = current_customer
 end
 
 def update
    @post = Post.find(params[:id])
    if params[:publicize_draft]
      @post.attributes = post_params.merge(is_draft: false)
      if @post.save(context: :publicize)
        redirect_to post_path(@post), notice: "下書きを公開しました！"
      else
        @post.is_draft = true
        render :edit, alert: "投稿を公開できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    elsif params[:update_post]
      @post.attributes = post_params
      if @post.save(context: :publicize)
        redirect_to post_path(@post), notice: "投稿を更新しました！"
      else
        render :edit, alert: "投稿を更新できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    else
      if @post.update(post_params)
        redirect_to post_path(@post), notice: "下書きを更新しました！"
      else
        render :edit, alert: "更新できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    end
 end 
 
 def destroy
   post = Post.find(params[:id])
   post.destroy
   redirect_to posts_path
 end 
 
 private
 
 def post_params
   params.require(:post).permit(:title, :text, :image, :nickname, :tag_list)
 end 
 
end 