class UserController < ApplicationController

  # no layout if xhr request
  layout Proc.new { |controller| controller.request.xhr? ? false : nil }, :only => [:update, :update_profile]

  def demo
    session[:demo_mode] = true;
    redirect_to dashboard_path
  end

  def update_profile
  end

  def update
    if @user.update_attributes(params[:user])
      #record_deed
      flash[:notice] = "User profile has been updated"
      ajax_redirect_to({ :action => 'profile', :user_id => @user.id })
    else
      render :action => 'update_profile'
    end
  end

  def profile
    @notes = @user.notes.limit(10)
    @page_versions = @user.page_versions.joins(:page).limit(10)
    @article_versions = @user.article_versions.limit(10).joins(:article)
  end

  def record_deed
    deed = Deed.new
    deed.note = @note
    deed.page = @page
    deed.work = @work
    deed.collection = @collection
    deed.deed_type = Deed::NOTE_ADDED
    deed.user = current_user
    deed.save!
  end

  def new_project_check_devise
    plan = params[:plan]
    
    if signed_in?
      redirect_to :action => :new_project_billing, :plan => params[:plan]
    else
#      binding.pry
      session[:nexturl] = { :controller => :user, :action => :new_project_billing, :plan => params[:plan]}
      redirect_to new_user_session_path
    end
  end

  def new_project_billing
    redirect_to "http://#{billing_host}/charges/new?plan_id=#{params[:plan]}&user_id=#{current_user.id}&email=#{current_user.email}"
  end

end