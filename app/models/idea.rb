class Idea < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy

  validates(:title, presence: true, uniqueness: true)

  validates(
    :body,
    presence: {
      message: "must be given" # creates custom valid. message
    },
    length: {
      minimum: 16, maximum: 2048
    }
  )

  # validates(
  #   :view_count,
  #   numericality: { greater_than_or_equal_to: 0 }
  # )
  # before_validation :set_view_count
  #
  # private
  # def set_view_count
  #   self.view_count ||= 0
  # end
end
