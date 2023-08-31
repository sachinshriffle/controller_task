class CollegesController < ApplicationController
	require 'byebug'
	skip_before_action :verify_authenticity_token

	def index 
		college = College.all
		render json: college
	end

	def create
    college = College.new(college_info)
    if college.save
      render json: college
    else
      render json: {errors: college.errors.messages}
    end
  end

  def destroy
  	college = College.find_by_id(params[:id])
  	if college
  	 college.destroy
  	 render json: {messages: "College Delete Succesfully!"}
  	else
  		render json: {message:"Data Not Found"}
  	end
  end

   def update
	  college = College.find_by_id(params[:id])

	  if college 
	  	c=college.update(college_info)
	  	if c 
	     render json: {data: college, message:"update succesfully"}
	    else
	     render json: {message: "College Name Can't Same Within City"}
	    end 
	  else
	    render json: {message: "Data Not Found"}
	  end
	end

	def show
	  college = College.find_by_id(params[:id])
	  if college
	    render json: college
    else
    	render json: {message: "Data Not Found"}
    end
	end

  def find_college
    college = College.joins(:courses).where("courses.course_name=?",params[:course_name])
    if college
     render json: college
    else
      render json: {message: "College Not Found Of This Course"}
    end
  end
  
  private
   def college_info
  	 params.permit(:college_name,:city)
   end
end