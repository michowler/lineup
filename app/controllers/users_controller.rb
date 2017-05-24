class UsersController < Clearance::UsersController
    before_action :hr, only: [:index,:new,:create,:destroy]

    def index
      session[:path] = request.fullpath
      @users = User.all.order("name").paginate(:page => params[:page], :per_page => 5)
    end


    def show
      session[:path] = request.fullpath
      @user = User.find(params[:id])
    end
    

    def create
        @user = User.new(create_params)
        if @user.save
          rl = RemainingLeafe.create(@user.total_leafe.attributes.slice!(:id))
          password = SecureRandom.base64
          @user.update(password: password,private_token: @user.email,remaining_leafe_id: rl.id)
          flash[:success] = "User has been created. Please check your email for the user password"
          UserMailer.create_user(@user,password).deliver
          redirect_to "/hr/dashboard"
        else
            flash.now[:info] = @user.errors.full_messages.first
            render template: "users/new"
        end
    end
  
    def edit
        @user = User.find(params[:id])
    end
    
    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:success] = "Update successful!"
            redirect_to session[:path]
        else
            flash.now[:danger] = "Update fail. Invalid inputs."
            render :edit
        end
    end

    def new
      @user = User.new
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      flash[:success] = "Employee removed from database"
      redirect_to "/users"
    end

    def pending
      user = User.find(params[:id])
      @leaves = user.leaves.where.not(status: "Approved").where("start_date >= ?", Date.today).order("start_date")
    end

    def history
      user = User.find(params[:id])
      @leaves = user.leaves.where("start_date < ?", Date.today).order("start_date DESC")
    end

    def upcoming
      user = User.find(params[:id])
      @leaves = user.leaves.where(status: "Approved").where("start_date >= ?", Date.today).order("start_date")
    end


  private

  def redirect_signed_in_users
  end

  # def url_after_create
  #   Clearance.configuration.redirect_url
  # end

	def user_params
		params.require(:user).permit(:name, :position, :email, :password_confirmation, :department, :manager_id, :phone_no, :private_token, :address, :avatar, :remove_avatar, total_leafe_attributes:[:id,:annual,:maternity,:study,:emergency,:sick,:non_paid])
	end 

  def create_params
    params.require(:user).permit(:name, :position, :email, :department, :manager_id, :phone_no, :address, :avatar,:password, total_leafe_attributes:[:id,:annual,:maternity,:study,:emergency,:sick,:non_paid])
  end 


end
