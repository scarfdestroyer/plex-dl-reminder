class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		if @user = User.create(user_params)
			redirect_to action: "show", id: @user.id
		end
	end

	def link_plex
		@plex_user = [plex_params]
		token = get_plex_token(@plex_user)
		user = User.find(params["user_id"])
		user.plex_token = token
		user.save!
		redirect_to action: "show", id: user.id
	end

	private

	def user_params
		params.required(:user).permit(:email, :password)
	end

	def plex_params
		params.permit(:username, :password)
	end

	def get_plex_token(plex_user)
		username = plex_user[0]["username"]
		password = plex_user[0]["password"]

		response = HTTParty.post('https://plex.tv/users/sign_in.json',
		:body => "user[login]=#{username}&amp;user[password]=#{password}",
		:headers => {
									"X-Plex-Client-Identifier" => "TESTSCRIPTV1",
									"X-Plex-Product" => "Test script",
									"X-Plex-Version" => "V1" } )

		response.parsed_response["user"]["authentication_token"]
	end
end