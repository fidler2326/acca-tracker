class V1::SessionsController < ApplicationController
  # TODO - work out why I need this (something to do with rails new --api that you don't get from a normal rails app)
  skip_before_action :verify_authenticity_token

  def create
    user = User.where(email: params[:email]).first
    if user && user.valid_password?(params[:password])
      p "HERE456"
      render json: user.as_json(only: [:email, :authentication_token]), status: :created
    else
      render json: { errors: "Email or password wrong." }, status: 422
    end
  end

  def destory

  end
end