class UsersController < ApplicationController
    before_action :authenticated_user!, except: [:new, :create]
    before_action :get_user, except: [:new, :create]
    before_action :authorize_user!, except: [:new, :create]

    def new
        @user = User.new
    end

    def create
        @user = User.new(params.require(:user).permit(:name, :email, :password, :password_confirmation))
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path
        else
            render :new, status: 303
        end
    end

    def edit

    end

    def update
        if @user.update(params.require(:user).permit(:name, :email))
            flash[:notice] = "User has been updated"
            redirect_to root_path
        else
            flash[:alert] = "User cannot be updated"
            render :edit, status: 303
        end
    end

    def edit_password

    end

    def change_password
        if @user && @user.authenticate(params[:current_password]) && !same_password?
            password = params[:new_password]
            password_confirmation = params[:new_password_confirmation]
            if @user.update(password: password, password_confirmation: password_confirmation)
                flash[:notice] = "Password has been updated"
                redirect_to root_path
            else
                render :edit_password, status: 303
            end
        else
            flash[:notice] = "Your current password is wrong or you cannot use same password!"
            render :edit_password, status: 303
        end
    end

    private
    def same_password?
        params[:current_password] == params[:new_password]
    end

    def get_user
        @user = current_user
    end

    def authorize_user!
        redirect_to root_path, alert: "Not authorized" unless params[:id].to_i == current_user.id
    end
    
end
