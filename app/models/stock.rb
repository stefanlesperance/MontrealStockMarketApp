class StockValidator < ActiveModel::Validator
	def validate(record)
		begin
			@stock = StockQuote::Stock.quote(record.ticker)
		rescue => @errorMsg
			@error = "That company symbol does not exist"
			record.errors.add :base, "This ticker does not exist"
		end
	end
end


class Stock < ApplicationRecord
	belongs_to :user
	validates_uniqueness_of :ticker, scope: :user_id
	validates :ticker, presence: true
	validates :ticker, format: { without: /\s/}
	validates_with StockValidator
end
