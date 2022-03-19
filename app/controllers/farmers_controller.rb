class FarmersController < ApplicationController

    before_action :params_find, only: [:show, :update, :edit ]
    before_action :farmer_params, only: [:create ]
    before_action :isFarmer, only: [:new, :create, :edit, :update, :mypage]
    

    require "mini_magick"

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
        if @farmers.save
            redirect_to farmers_path

        else
            redirect_to root_path, notice: "You already have a farmer page, please edit your existing page. If you feel this is an error, please contact support."
        end

        #   the above redirect path needs to be fixed. 
    end


    def update
        @farmers.update(farmer_params)
        redirect_to @farmers, notice: "Details updated"
    end

    def params_find
        @farmers = Farmer.find(params[:id])
    end

    def farmer_params
        params.require(:farmer).permit(:name, :about, :abn, :user_id, photos: [])
    end

    def delete_photo
        photo = ActiveStorage::Attachment.find(params[:id])
        photo.purge
        redirect_back(fallback_location: farmers_path)
      end

      def mypage
        @farmers = Farmer.all
      end

    private 
    def isFarmer
        begin
        if user_signed_in? and (!current_user.admin? or !current_user.farmer?)
            redirect_to products_path, alert: "You must be a registered farmer to access these pages"
        else
        if !user_signed_in?
            redirect_to products_path, alert: "Please login as a farmer to access this page"
        end
    end
        rescue StandardError => e
            puts e.message
            redirect_to products_path, alert: "Please login as a farmer to view"
        end
    end
end

