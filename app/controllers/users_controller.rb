class UsersController < ApplicationController
  def index
    render plain: Repo.users.all.inspect
  end

  def new
    @user = {record: User.empty.with(login: 'Foo"bar')}
    render :new
  end

  def create
    @user = User.create(params[:user])
    if @user[:errors]
      render :new
    else
      redirect_to users_path
    end
  end
end
