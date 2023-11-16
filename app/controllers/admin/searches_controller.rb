class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!
  
  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    
    # 選択したモデルに応じて検索を実行
    if @model  == "customer"
      @records = Customer.search_for(@content, @method)
    else
      @records = Post.search_for(@content, @method)
    end
  end
end
