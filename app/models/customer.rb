class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  enum status: { available: 0, suspended: 1 }
  has_many :reporter, class_name: "Report", foreign_key: "reporter_customer_id", dependent: :destroy
  has_many :reported, class_name: "Report", foreign_key: "reported_customer_id", dependent: :destroy
  
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
  
  def full_name
    self.first_name + " " + self.last_name
  end

  def full_name_kana
    self.first_name_kana + " " + self.last_name_kana
  end
  
  def self.search_for(content, method)
    if method == 'perfect'
      Customer.where(first_name: content)
    elsif method == 'forward'
      Customer.where('first_name LIKE ?', content + '%')
    elsif method == 'backward'
      Customer.where('first_name LIKE ?', '%' + content)
    else
      Customer.where('first_name LIKE ?', '%' + content + '%')
    end
  end
  
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
  end
  
end
