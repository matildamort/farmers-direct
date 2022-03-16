class FarmersController < ApplicationController

    before_action :params_find, only: [:show, :update, :edit]
    before_action :farmer_params, only: [:create]

    def index
        @farmers = Farmer.all
    end

    def new
        @farmer = Farmer.new  
    end

    def edit
    end

    def show
    end

    def create
        @farmers = Farmer.create(farmer_params)
        redirect_to farmers_path

        #   the above redirect path needs to be fixed.
       
    end

    def update
        @farmer.update(farmer_params)
        redirect_to @farmers, notice: "Details updated"
    end

    def params_find
        @farmers = Farmer.find(params[:id])
    end

    def farmer_params
        params.require(:farmer).permit(:name, :about, :abn, :user_id, :photos)
    end


    def isFarmer
        if !current_user.farmer or !current_user.admin
            redirect_to user_session_path, alert: "You must be a registered farmer to view this page, sign-in or register"
        end
    end

end

