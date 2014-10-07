class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	respond_to :html, :json, :xml

# :nocov:

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

# :nocov:

	def new
		@user = User.new
	end

	def edit
	end

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user			
			flash[:sucess] = 'Bem vindo ao Espelho Político!'
			redirect_to @user
		else
			render 'new'
		end
	end

	def update
		@user.update(user_params)
		flash[:notice] = 'Usuário atualizado com sucesso!' if @user.save
		respond_with(@user)
	end

	def destroy
		@user.destroy
		flash.now[:notice] = 'Usuário foi excluído com sucesso!'
		respond_with(@user)
	end

# :nocov:

	def authenticate
		@user = User.find(params[:id])
	end

# :nocov:

	private
		def set_user
			@user = User.find(params[:id])
		end

		def user_params
			params.require(:user).permit(:name, :email, :password, :username, :password_confirmation)
		end
end