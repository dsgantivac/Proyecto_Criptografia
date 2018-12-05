require "Algorithms/des.rb"
require "Algorithms/polarcrypt.rb"
require "Algorithms/RSA2.rb"

class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]


  # GET /articles
  # GET /articles.json
  def index
    if(current_user != nil)
      @user = current_user
      @articles = Article.where(user_id: @user.id)
    else
      @articles = []
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    if(current_user != nil)
      @user = current_user.name
      @key = generate_keys()
      #@pin = rsa_encrypt(current_user.pin,11,5475599)
      @pin = rsa_encrypt(current_user.pin,@key[0],@key[2])
      @pin2 = current_user.pin
      @article

    end
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    if(current_user != nil)
      @user = current_user
      if @article.encryptType == 'DES'
        @article.body = decrypt(@article.body,@user.pin)
      else
        @article.body = decriptar(@article.body,@user.pin)
      end
    end
  end

  # POST /articles
  # POST /articles.json
  def create
    @user = current_user
    @article = Article.new(article_params)
    @article.user_id = @user.id

    if @article.encryptType == 'DES'
      @article.body = encrypt(@article.body.force_encoding('ASCII-8BIT'),@user.pin)
    else
      @article.body = encriptar(@article.body,@user.pin)
    end

    respond_to do |format|
      if @article.save
        format.html { redirect_to "/articles", notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    body=""
    @user = current_user
    if article_params["encryptType"] == 'DES'
      body = encrypt(article_params["body"],@user.pin)
    else
      body = encriptar(article_params["body"],@user.pin)
    end

    respond_to do |format|
      if @article.update({"title"=>article_params["title"], "body"=>body, "encryptType"=>article_params["encryptType"]})
        format.html { redirect_to "/articles", notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
      @user = User.find(current_user.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit( :title, :body, :encryptType)
    end
end
