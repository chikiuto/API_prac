class User < ApplicationRecord
  has_secure_password
  validates :email, {uniqueness: true}
  validates :email, {presence: true}
  validates :name, {uniqueness: true}
  validates :name, {presence: true}
  validates :password_digest, {presence: true}
end
