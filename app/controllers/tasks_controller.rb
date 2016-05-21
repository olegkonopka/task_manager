class TasksController < ApplicationController

	before_action :set_task_id, only: [ :edit, :update]
	before_action :authenticate_user!
	respond_to :json, :html, :js

	def new
		@task = Task.new
	end

	def create
		@task = Task.new(task_params)
		respond_to do |format|
			if @task.save
				format.json{ render :show, status: :created, location: @task }
				format.html{ redirect_to root_path, notice: "Task successfully created!!!!" }
				format.js
			else
				format.html { render :edit }
        		format.json { render json: @task.errors, status: :unprocessable_entity }
        		format.js
			end

		end
	end

	def show
		@task = Task.find(params[:id])
	end

	def edit
	end
	def index
		@tasks = Task.all.paginate(:page => params[:page], :per_page => 30)
		@userTasks = current_user.tasks.paginate(:page => params[:page], :per_page => 10)
	end

	def update
		respond_to do |format|
	      if @task.update(task_params)
	      	format.js
	        format.html { redirect_to root_path, notice: 'Task was updated!!!' }
	        format.json { render :show, status: :ok, location: @task }
	      else
	        format.html { render :edit }
	        format.json { render json: @task.errors, status: :unprocessable_entity }
	      end
	  	end
	end

	def destroy
		@task=Task.destroy(params[:id])
		respond_to do |format|
			format.js
			format.json 
			format.html { redirect_to @task, notice: "Task successfully destroyed!!!" }
		end
	end


	private

	def set_task_id
		@task = Task.find(params[:id])
	end

	def task_params
		params.require(:task).permit(:title, :description, :start_date, :end_date, :priority, :user_ids => [] )
	end

end
