class PhoneNumberController < ApplicationController

	def create
		phone_number = params[:phone].present? ? params[:phone] : generate_phone_number
		while PhoneNumber.exists?(phone: phone_number)
			phone_number = generate_phone_number
		end
		PhoneNumber.create(phone: phone_number)
		render json: {phone: phone_number}
	end

	def generate_phone_number
		first_three = 3.times.map {|n| random_number}.join
		middle_three = 3.times.map {|n| random_number}.join
		last_four = 4.times.map {|n| random_number}.join
		"#{first_three}-#{middle_three}-#{last_four}"
	end

	def random_number
		number = rand(9)
		while(number == 0) # Skip 0 digit
			number = rand(9)
		end
		number
	end

end
