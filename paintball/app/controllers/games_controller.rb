class GamesController < ApplicationController
  layout 'dashboard'
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :set_member
  before_action :authenticate_member!, except: [:index, :show ]



  def index
    @games = Game.all
  end


  def show
    @reviews = Review.where(game_id:@game.id).order("created_at DESC")
    if @reviews.blank?
      @avg_review = 0
    else
      @avg_review = @reviews.average(:rating).round{2}
    end
  end


  def new
    @game = Game.new
  end


  def edit
  end

  
  def create
    @game = Game.new(game_params)
    @game.member_id =  @member.id

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_game
      @game = Game.friendly.find(params[:id])
      
    end


    def game_params
      params.require(:game).permit(:title, :image, :description, :slug)
    end


    def set_member
        @member = current_member
    end
end
