class Public::TagsController < ApplicationController
  def show
    tag_name = params[:id]
    tagged_posts = Post.tagged_with(tag_name)
    @tagged_posts = tagged_posts.where(is_draft: false)
    @tags = Post.tag_counts_on(:tags)
    @tag = ActsAsTaggableOn::Tag.find_by(name: tag_name)
    @total_posts_count = @tagged_posts.count
    @tagged_posts = @tagged_posts.page(params[:page]).per(12)
    @post_comments = PostComment.all
    # @post_comment = PostComment.find(params[:id])
    render 'show'
  end
end
