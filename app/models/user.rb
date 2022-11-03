class User < ApplicationRecord
  validates :email, {uniqueness: true}
  validates :name, {uniqueness: true}, {presence: true}
  validates :password, {presence: true}
end
