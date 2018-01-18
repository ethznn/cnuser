require ('nokogiri')
require ('open-uri')


class HomeController < ApplicationController
    
  def index
    @online_game_rank_list = []
    @online_game_rank_page = Nokogiri::HTML(open("http://onlinegamesoonwe.com/bbs/board.php?bo_table=G01"))
    @online_game_rank_page.css('div.mw_basic_list_subject_desc/a/span').each do |x|
      @online_game_rank_list << x.text
    end
    
    @mobile_game_rank_list = []
    @mobile_game_rank_page = Nokogiri::HTML(open("http://www.gevolution.co.kr/rank/overall.asp"))
    @mobile_game_rank_page.css('a.tracktitle').each do |y|
      @mobile_game_rank_list << y.text
    end 
  end

  def list
  end

  
  def add
  end
  
  def new
    post = Post.new
    post.post_name = params[:writer]
    post.post_title = params[:title]
    post.post_content = params[:content]
    post.post_password = params[:password]
    post.post_password2 = ""
    time = Time.new
    post.post_time = time.inspect
    if (post.post_title == nil || post.post_password == nil || post.post_name == nil || post.post_content == nil)
      redirect_to :back, flash: {notice: "빈칸 없이 입력해주세요."}
    else
      post.save
      redirect_to "/home/board_lol"
    end
  end
  
  def body
    @one_post = Post.all.find(params[:id])
    @replies = Reply.all.order("id desc")
    
  end
  
  def board_lol
    @posts = Post.all
    if params[:search]
      @posts = Post.all.search(params[:search]).order("id desc").paginate(:page => params[:page], :per_page => 10)
    else
      @posts = Post.all.order("id desc").paginate(:page => params[:page], :per_page => 10)
    end
    
  end

  def destroy
    post = Post.find(params[:id])
    post.post_password2 = params[:password]
    if post.post_password2 == post.post_password
      @destroy = Post.all.find(params[:id])
      @destroy.destroy
      redirect_to "/home/board_lol"
    elsif post.post_password2 == ""
      redirect_to :back, flash: {notice: "비밀번호를 입력해주세요."}
    elsif post.post_password2 != post.post_password
      redirect_to :back, flash: {notice: "비밀번호가 틀렸습니다."}
    end
  end
  
  def update_view
    @update_view = Post.find(params[:id])
  end
  
  def destroy_view
    @destroy_view = Post.find(params[:id])
  end
  
  def update
    post = Post.find(params[:id])
    post.post_password2 = params[:password]
    
    if post.post_password2 == ""
      redirect_to :back, flash: {notice: "비밀번호를 입력해주세요."}
    elsif post.post_password2 == post.post_password
          post.post_name = params[:writer]
          post.post_title = params[:title]
          post.post_content = params[:content]
          time = Time.new
          post.post_time = time.inspect
          post.save
        redirect_to "/home/board_lol"
    elsif post.post_password2 != post.post_password
      redirect_to :back, flash: {notice: "비밀번호가 틀렸습니다."}
    end
    
  end

  def reply
    reply = Reply.new
    reply.content = params[:content]
    reply.name = params[:name]
    reply.post_id = params[:post_id]
    reply.save
    
    redirect_to :back
  end

end