class WelcomeController < ApplicationController
    def home
    end
  
    def about
    end
  
    def contact_us
    end
  
    def thank_you
      @name = params[:name]
      @email = params[:email]
      @question = params[:question]
    end
  end