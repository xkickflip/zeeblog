class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "chris",
                               password: "xxx",
                               except: [:index, :show]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new article_params

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find params[:id]

    if @article.update article_params
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find params[:id]
    @article.destroy

    redirect_to articles_path
  end

  private

    # factored out to reuse between create / update as well as have it be private
    # so it's not used outside of it's intended use case
    def article_params
      params.require(:article).permit(:title, :text)
    end

end
