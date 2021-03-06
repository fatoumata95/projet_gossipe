class Gossip < ApplicationRecord
	validates :title, presence: true, length: { in: 3..14}
	validates :content, presence: true
	belongs_to :user
	has_many :join_table_gossips_tags
	has_many :tags, through: :join_table_gossips_tags
end
