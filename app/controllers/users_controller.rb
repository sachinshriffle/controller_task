class UsersController < ApplicationController
	require 'byebug'
	skip_before_action :verify_authenticity_token

	def index 
		@user = User.all
		render json: @user
	end

	def create
    @user = User.new(user_info)
    if @user.save
      render json: @user
    else
      render json: {errors: @user.errors.messages}
    end
  end

  def destroy
  	@user = User.find_by_id(params[:id])
  	if @user
  	 @user.destroy
  	 render json: {messages: "user Delete Succesfully!"}
  	else
  		render json: {message:"Data Not Found"}
  	end
  end

   def update
	  @user = User.find_by_id(params[:id])

	  if @user 
	  	u=@user.update(user_info)
	  	if u
	      render json: {data: @user,message: "User Update Succesfully"}
	    else
	    	render json: {message: "User Already Exist"}
	    end
	  else
	    render json: {message: "Data Not Found"}
	  end
	end

	def show
	  @user = User.find_by_id(params[:id])
	  if @user
	    render json: @user
    else
    	render json: {message: "Data Not Found"}
    end
	end

  def find_user
    @user = User.joins(:course).select("courses.course_name ,group_concat(name)").group('courses.course_name')
    if @user
     render json: @user
    else
      render json: {message: "User Not Found"}
    end
  end
  
  private
   def user_info
  	 params.permit(:name,:mobile_number,:age,:course_id)
   end
end