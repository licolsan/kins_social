class Channel < ApplicationRecord
	has_many :messages, dependent: :destroy
	has_many :subscriptions, dependent: :destroy
	has_many :users, through: :subscriptions

	scope :group_chat, -> { where.not(name: "Blank name") }

	validates :name, presence: true
end
