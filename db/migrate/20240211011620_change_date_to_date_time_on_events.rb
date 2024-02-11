class ChangeDateToDateTimeOnEvents < ActiveRecord::Migration[7.0]
  def change
    change_column :events, :start_date, :datetime
    change_column :events, :end_date, :datetime

    change_column :collections, :date, :datetime

    change_column :challenges, :start_date, :datetime
    change_column :challenges, :end_date, :datetime

    change_column :activities, :start_date, :datetime
    change_column :activities, :end_date, :datetime

    remove_column :score_records, :date, :date
  end
end
