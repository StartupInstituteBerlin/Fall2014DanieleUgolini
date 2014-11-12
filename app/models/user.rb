class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	
	validates :name, presence: true
	validates :role, inclusion: { in: ["owner", "patron"] }
	
	has_many :restaurants, dependent: :destroy    

	def owner?
		role == "owner"
	end

	def patron?
		role == "patron"
	end

end
