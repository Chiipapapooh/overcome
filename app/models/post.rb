class Post < ApplicationRecord
  belongs_to :customer
  
  with_options presence: true, on: :publicize do
     validates :title, presence: true
     validates :text, presence: true
     validates :image
  end 
  
  # def nickname
  # @post.nickname
  # end 
  
  has_one_attached :image
  
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

  private
  
  def image_type
    if !image.blob
      errors.add(:image, 'をアップロードしてください')
    elsif !image.blob.content_type.in?(%('image/jpeg image/png'))
      errors.add(:image, 'はJPEGまたはPNG形式を選択してアップロードしてください')
    end
  end
end
