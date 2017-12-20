class MicropostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update,:destroy]

 def index
   if logged_in?
     #@microposts = micropost.allpage(params[:page])
     @microposts = current_user.microposts.page(params[:page])
   end
 end
 
 def show
 end
 
 def new
 @micropost = micropost.new
 end
 
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @microposts = current_user.feed_microposts.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

def edit
end

def update
  
  if @micropost.update(micropost_params)
    flash[:success] = 'メッセージは正常に更新されました。'
    redirect_to @micropost
  else
    flash.now[:danger] = 'メッセージは更新されませんでした。'
    render :edit
  end
end

  def destroy
    @micropost.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_to microposts_ur1
  end

  private
  
  # Strong Parameter
  def micropost_params
    params.require(:micropost).permit(:content, :status)
  end
end
