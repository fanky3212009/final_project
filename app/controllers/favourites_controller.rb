class FavouritesController < ApplicationController
  layout 'favourites_layout', only: [:index]


  def index

    if params[:search]
      @search_results = Favourite.most_favourited_diaries
      respond_to do |format|
        format.js
      end
    else

      if params[:user_id]
        @user = User.find(params[:user_id])
        if current_user == @user
          @user = current_user
          @favourites = @user.favourites
          # if params[:search]
          #   @search_results = @search_results.select {|d| d.title.include?params[:search]}
          # end
          respond_to do |format|
            format.html
            format.js
          end

        else
          render file: "#{Rails.root}/public/404.html", layout: false, status: 404
        end
      end
    end

  end


  def create
    @user = current_user
    if params[:diary_entry_id]
      @diary_entry = DiaryEntry.find(params[:diary_entry_id])
      @favourite = @diary_entry.favourites.build

    else
      @journey = Journey.find(params[:journey_id])
      @favourite = @journey.favourites.build
    end

    @favourite.user_id = @user.id

    if @favourite.save
      respond_to do |format|
          format.html
          format.json {render json: @favourite}
      end
    end


  end

  def destroy
    @favourite = Favourite.find(params[:id])
    @favourite.destroy
    respond_to do |format|
      format.html
      format.json {render json: @favourite}
  end

  end

  # private
  # def favourite_params
  #   params.require(:favourite).permit(:favourable_id, :favourable_id)
  #   #code
  # end
end
