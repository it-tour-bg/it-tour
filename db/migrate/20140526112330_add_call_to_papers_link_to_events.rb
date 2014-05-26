class AddCallToPapersLinkToEvents < ActiveRecord::Migration
  def change
    add_column :events, :call_to_papers_url, :string
  end
end
