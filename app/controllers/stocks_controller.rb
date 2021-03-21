class StocksController < ApplicationController
  before_action :set_stock, only: %i[ show edit update destroy ]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :stock_exists, only: [:create]

  # GET /stocks or /stocks.json
  def index
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
    @stocks = Stock.all
  end

  # GET /stocks/1 or /stocks/1.json
  def show
  end

  # GET /stocks/new
  def new
    @stock = Stock.new
  end

  # GET /stocks/1/edit
  def edit
  end

  # POST /stocks or /stocks.json
  def create
    @stock = Stock.new(stock_params)

      respond_to do |format|
          if @stock.save
              format.html { redirect_to @stock, notice: "Stock was successfully created." }
              format.json { render :show, status: :created, location: @stock }
              puts "This has reached the Log."
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @stock.errors, status: :unprocessable_entity }
          end
      end
  end

  # PATCH/PUT /stocks/1 or /stocks/1.json
  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to @stock, notice: "Stock was successfully updated." }
        format.json { render :show, status: :ok, location: @stock }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1 or /stocks/1.json
  def destroy
    @stock.destroy
    respond_to do |format|
      format.html { redirect_to stocks_url, notice: "Stock was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @ticker = current_user.stocks.find_by(id: params[:id])
    redirect_to stocks_path, notice: "Not Authorized to Edit This Stock" if @ticker.nil?
  end

  def stock_exists
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stock_params
      params.require(:stock).permit(:ticker, :user_id)
    end
end
