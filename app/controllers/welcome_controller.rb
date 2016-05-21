class WelcomeController < ApplicationController
  def index
  	if signed_in?
  		@user = User.find(current_user)
		@task = Task.new
	  	@tasks = @user.tasks
	  	@tasksAll = Task.all
	  end
  end
end
