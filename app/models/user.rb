class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :cart

  validates :phone_number, phone: { possible: false, allow_blank: true }


  def formatted_phone_number
    phone = Phonelib.parse(phone_number)
    formatted = phone.full_e164.presence || phone.full_national.presence
  end

  def full_name
    "#{first_name} #{last_name}".strip
  end
end
