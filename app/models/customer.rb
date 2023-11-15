class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  enum status: { available: 0, suspended: 1 }
  has_many :reporter, class_name: "Report", foreign_key: "reporter_id", dependent: :destroy
  has_many :reported, class_name: "Report", foreign_key: "reported_id", dependent: :destroy
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  scope :only_active, -> { where(is_active: true) }

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :email, presence: true, uniqueness: true
  
  # def first_name
  # end
  
  # def last_name
  # end
  
  # def first_name_kana
  # end 
  
  # def last_name_kana
  # end 
  
  def full_name
    self.first_name + " " + self.last_name
  end

  def full_name_kana
    self.first_name_kana + " " + self.last_name_kana
  end
  
end
