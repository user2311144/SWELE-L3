class BookmarksController < ApplicationController
  # edit, update, destroyアクションの前に、set_bookmarkメソッドを実行する
  before_action :set_bookmark, only: [:edit, :update, :destroy]

  def index
    @bookmarks = Bookmark.all
  end
  
  def new
    @bookmark = Bookmark.new
  end
  
  def create
    @bookmark = Bookmark.new(bookmark_params)
    if @bookmark.save
      redirect_to bookmarks_path, notice: 'ブックマークが正常に作成されました。'
    else 
      render :new, alert: 'ブックマークの作成に失敗しました。'
    end
  end
  
  def destroy
    @bookmark.destroy
    redirect_to bookmarks_path, notice: 'ブックマークを削除しました。'
  end
  
  def show
    @bookmark = Bookmark.find(params[:id])
  end
  
  def edit
    # before_actionで@bookmarkが設定される
  end
  
  def update
    if @bookmark.update(bookmark_params)
      redirect_to bookmarks_path, notice: 'ブックマークが正常に更新されました。'
    else
      render :edit, alert: 'ブックマークの更新に失敗しました。'
    end
  end

  private

  # IDを使ってブックマークを取得し、@bookmark変数に代入するプライベートメソッド
  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end
  
  # 安全なパラメータのみを許可するプライベートメソッド
  def bookmark_params
    params.require(:bookmark).permit(:title, :url)
  end
end