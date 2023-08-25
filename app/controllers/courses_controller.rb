class CoursesController < ApplicationController
	require 'byebug'
	skip_before_action :verify_authenticity_token

  def index
  	@course = Course.all 
  	render json: @course
  end

  def create
    @course = Course.new(course_info)
    if @course.save
      render json: @course
    else
      render json: {errors: @course.errors.messages}
    end
  end

  def destroy
  	@course = Course.find_by_id(params[:id])
  	if @course
  	 @course.destroy
  	 render json: {messages: "Course Delete Succesfully!"}
  	else
  		render json: {message:"Data Not Found"}
  	end
  end

  def update
	  @course = Course.find_by_id(params[:id])

	  if @course 
	  	u=@course.update(course_info)
	  	if u
	      render json: {data: @course,message: "Course Update Succesfully"}
	    else
	    	render json: {message: "Course Already Exist"}
	    end
	  else
	    render json: {message: "Data Not Found"}
	  end
	end

	def show
	  @course = Course.find_by_id(params[:id])
	  if @course
	    render json: @course
    else
    	render json: {message: "Data Not Found"}
    end
	end
  
  private
  def course_info
  	params.permit(:course_name,:college_id)
  end
end
