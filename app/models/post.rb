class Post < ApplicationRecord
  belongs_to :customer
  
  with_options presence: true, on: :publicize do
     validates :title, presence: true
     validates :text, presence: true
     validates :image
  end 
 
  has_one_attached :image
  
  # gem:acts_as_taggableの使用
  acts_as_taggable_on :tags
  
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :vision_api_tags, dependent: :destroy
  
  def favorited_by?(customer)
   favorites.exists?(customer_id: customer.id)
  end
  
  def get_image(*size)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      image.attach(io: File.open(file_path), filename: 'no_image.png', content_type: 'image/png')
    end
    
    if !size.empty?
      image.variant(resize: size)
    else
      image
    end
  end
  
  def self.liked_posts(customer, page, per_page) # 1. モデル内での操作を開始
  includes(:post_favorites) # 2. post_favorites テーブルを結合
    .where(post_favorites: { customer_id: customer.id }) # 3. ユーザーがいいねしたレコードを絞り込み
    .order(created_at: :desc) # 4. 投稿を作成日時の降順でソート
    .page(page) # 5. ページネーションのため、指定ページに表示するデータを選択
    .per(per_page) # 6. ページごとのデータ数を指定
  end
  
  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(title: content)
    elsif method == 'forward'
      Post.where('title LIKE ?', content + '%')
    elsif method == 'backward'
      Post.where('title LIKE ?', '%' + content)
    else
      Post.where('title LIKE ?', '%' + content + '%')
    end
  end

  private
  
  def image_type
    if !image.blob
      errors.add(:image, 'をアップロードしてください')
    elsif !image.blob.content_type.in?(%('image/jpeg image/png'))
      errors.add(:image, 'はJPEGまたはPNG形式を選択してアップロードしてください')
    end
  end
end
