class Api::V1::UsersController < ApplicationController

    def update
        @user = User.find_by_id(params[:id])
        if @user.nil?  
            render status: 404, json: {error: "User not found"}
        else
            @user.update_attributes(params)
            render status: 200, json: => {message: "User has been updated"}
  end
end

end

