class AddressesController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index
		address = Address.all
		render json: address
	end

  def create
  	path = request.path
  	if path.include?("user")
  		user= User.find_by_id(params[:user_id])
  		render json: {message:"user not found"} if user.blank?
  		address = user.build_address(address_info)
      if address.save
      render json: address
      else
      render json: {errors: address.errors.messages}
      end
    else
    	college = College.find_by_id(params[:college_id])
    	render json: {message:"college not found"} if college.blank?
    	address = college.build_address(address_info)
    	if address.save
      render json: address
      else
      render json: {errors: address.errors.messages}
      end
    end
  end

  def show
  	path = request.path
  	if path.include?("users")
  		user= User.find_by_id(params[:user_id])
  		if user.blank?
  		 render json: {message:"user not found"}
  		else
	     address = user.address
	     if address
	       render json: address
       else
    	   render json: {message: "Address Not Available"}
       end
     end
    else
    	college = College.find_by_id(params[:college_id])
    	address = college.address
    	render json: address
    end
	end

	def destroy
  	address = Address.find_by_id(params[:id])
  	if address
  	 address.destroy
  	 render json: {messages: "Address Delete Succesfully!"}
  	else
  		render json: {message:"Data Not Found"}
  	end
  end

  def update
	  address = Address.find_by_id(params[:id])

	  if address 
	  	u=address.update(address_info)
	  	if u
	      render json: {data: address,message: "Address Update Succesfully"}
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
