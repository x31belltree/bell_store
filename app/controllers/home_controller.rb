class HomeController < ApplicationController
    def index
        if admin_signed_in?
            redirect_to admins_products_path 
        elsif user_signed_in?
            redirect_to products_path
        end
    end
end
