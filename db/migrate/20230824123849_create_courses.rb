class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :course_name
      t.references :college , foreign_key:true , null:false
      
      t.timestamps
    end
  end
end
