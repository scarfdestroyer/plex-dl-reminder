class AddPlexTokenToUsers < ActiveRecord::Migration[5.0]
	def change
		add_column :users, :plex_token, :string
	end
end
