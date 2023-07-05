# frozen_string_literal: true

class Api::V1::SessionsController < Devise::SessionsController
  before_action :sign_in_params, only: :create
  before_action :load_user, only: :create
  before_action :valid_token, only: :destroy
  skip_before_action :verify_signed_out_user, only: :destroy
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    if @user.valid_password?(sign_in_params[:password])
      sign_in "user", @user
      json_response "Sign In Successfully", true , {user: @user}, :ok
    else
      json_response "Unauthorized", false, {}, :unauthorized
    end
  end

  # DELETE /resource/sign_out
  def destroy
    sign_out @user
    @user.generate_new_authentication_token
    json_response "Log out Successfully", true, {}, :ok
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  private
  def sign_in_params
    params.require(:sign_in).permit(:email, :password)
    # return hash
    # {
    #   email: "jsons",
    #   password: "jsons"
    # }
  end

  def load_user
    @user = User.find_for_database_authentication(email: sign_in_params[:email])
    return @user if @user
    json_response "Cannot get User", false, {}, :unauthorized
  end

  def valid_token
    @user = User.find_by authentication_token: request.headers['AUTH-TOKEN']
    return @user if @user
    json_response "Invalid Token", false, {}, :unauthorized
  end
end
