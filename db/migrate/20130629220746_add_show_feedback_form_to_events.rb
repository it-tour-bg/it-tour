class AddShowFeedbackFormToEvents < ActiveRecord::Migration
  def change
    add_column :events, :show_feedback_form, :boolean, null: false, default: false
  end
end
