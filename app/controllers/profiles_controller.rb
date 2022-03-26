class ProfilesController < ApplicationController

  def after_sign_up_path_for(resource)
    profiles_new_path
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
    if @profile.save
      redirect_to :root
    else
      render :new
    end
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      redirect_to edit_profile_path(current_user.id)
    end
  end

  private
  def profile_params
    params.require(:profile).permit(:profile_name, :self_introduction, :avatar)
  end

end
