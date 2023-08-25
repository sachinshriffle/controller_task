class AddressesController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index
		@address = Address.all
		render json: @address
	end

  def create
    @address = Address.new(address_info)
    if @address.save
      render json: @address
    else
      render json: {errors: @address.errors.messages}
    end
  end

  def show
	  @address = Address.find_by_id(params[:id])
	  if @address
	    render json: @address
    else
    	render json: {message: "Data Not Found"}
    end
	end

	def destroy
  	@address = Address.find_by_id(params[:id])
  	if @address
  	 @address.destroy
  	 render json: {messages: "Address Delete Succesfully!"}
  	else
  		render json: {message:"Data Not Found"}
  	end
  end

  def update
	  @address = Address.find_by_id(params[:id])

	  if @address 
	  	u=@address.update(address_info)
	  	if u
	      render json: {data: @address,message: "Address Update Succesfully"}
	    else
	    	render json: {message: "Address Already Exist"}
	    end
	  else
	    render json: {message: "Data Not Found"}
	  end
	end

	private
  def address_info
  	params.permit(:area,:city,:addressable_type,:addressable_id)
  end
end
