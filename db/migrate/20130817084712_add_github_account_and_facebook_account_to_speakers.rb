class AddGithubAccountAndFacebookAccountToSpeakers < ActiveRecord::Migration
  def change
    add_column :speakers, :github_account, :string
    add_column :speakers, :facebook_account, :string
  end
end
