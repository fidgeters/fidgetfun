class PagesController < ApplicationController
  def show
    if valid_page?
      authentication_required?

      render template: "pages/#{params[:page]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private
  def valid_page?
    File.exist?(Pathname.new(Rails.root + "app/views/pages/#{params[:page]}.slim"))
  end

  def authentication_required?
    protected_pages = ["secret"]

    if protected_pages.include?(params[:page].downcase)
      authenticate_user!
    end
  end
end
