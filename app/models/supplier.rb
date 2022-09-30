class Supplier < ApplicationRecord
  has_many :product_models

  validates :corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :email, :phone_number,
            presence: true
  validates :registration_number, uniqueness: true
  validates :registration_number, cnpj: true

  def sup_description
    "#{brand_name} - #{corporate_name} - #{registration_number}"
  end

end
