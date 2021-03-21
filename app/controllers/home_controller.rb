class HomeController < ApplicationController
  def index
  	@api = StockQuote::Stock.new(api_key: 'sk_7bb175e877654560b24652d79cde39d1')
  		if params[:ticker] == ""
  		@nothing = "Hey! You Forgot to Enter A Symbol"
  	elsif params[:ticker]
      begin
        @stock = StockQuote::Stock.quote(params[:ticker]).nil? 
      rescue => @newErrorMsg
        @nErrorMsg = "Caught this error"
        puts "Caught You!"
      end
  		begin
  			@stock = StockQuote::Stock.quote(params[:ticker]) 
        logger.debug "Checking if this works or not"
  		rescue => @errorMsg
  			@error = "That company symbol does not exist"
        puts @error.inspect
  		end
  	end
  end

  #This is the material necessary for a manual creation of the page
  #def about
  #end
  #whatever you name it here, must also be the name of corresponding viewpage
  def about
  end

end
