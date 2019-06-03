class AddCourseAndTimeToLeg < ActiveRecord::Migration[5.1]
  def change
    add_column :legs, :course, :string
    add_column :legs, :race_time, :time
  end
end