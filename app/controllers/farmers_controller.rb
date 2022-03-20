class FarmersController < ApplicationController

    before_action :params_find, only: [:show, :update, :edit ]
    before_action :farmer_params, only: [:create ]
    before_action :isFarmer, only: [:new, :create, :edit, :update, :mypage]
    
    # Required to allow farmer to upload multiple images. 
    require "mini_magick"

    def index
        #@farmers = Farmer.all.order("farmer.name").eager_load(:name) - Attempt at Eagerloading, not taught in class and not great great resources easy to find :(
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
                #If the farmer can save thier new farm page, it will do so. 
                redirect_to farmers_path

            else 
                #If they are unable to create a farmer page, it will let them know. This is controlled in the model through a validates uniqueness to prevent farmer creating more than one page. 
                redirect_to root_path, notice: "You already have a farmer page, please edit your existing page. If you feel this is an error, please contact support."
            end
    end

    #allows farmer to update thier about them page. 
    def update
        @farmers.update(farmer_params)
        redirect_to @farmers, notice: "Details updated"
    end

    def params_find
        @farmers = Farmer.find(params[:id])
    end

    def farmer_params
        params.require(:farmer).permit(:name, :about, :abn, :user_id, photos: [] ) 
        #Regular params, photo is an array and support mulitple picture uploads and assigned to that farmer. 
    end

    #ability to delete photo (I think this is removed from views currently, to be re-added, not commenting out as required for future dev)
    def delete_photo
        photo = ActiveStorage::Attachment.find(params[:id])
        photo.purge
        redirect_back(fallback_location: farmers_path)
      end

      def mypage
        @farmers = Farmer.all
      end

    private 

    # Prevents user accessing pages if they are not a farmer, e.g if they had a page saved or followed a link and they were not logged in or only logged in as a general user. 
    def isFarmer
        begin
            if user_signed_in? and !current_user.farmer?
                # if user_signed_in? and (!current_user.farmer or !current_user.admin) - This should be the correct permission, however prevents farmer accessing elements. Add to bug fixes for future dev.
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

