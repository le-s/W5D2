class PostsController < ApplicationController
  def new
  end

  def create
    post = Post.new(post_params)
    post.author_id = current_user.id
    post.sub_id = params[:sub_id]

    if post.save
      redirect_to sub_url(post.sub_id)
    else
      flash[:errors] = post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = current_user.posts.find(params[:id])

    if post.update_attributes(post_params)
      redirect_to sub_post_url(post)
    else
      flash[:errors] = post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  # params = { id => 1, title => dfg}
  # input type = text name="title"
  #
  # params = { id: 1 , user = {username: "tom"}}
  # params[:user][:username]
  # name = "user[username]"
  #
  # name = "username"
  # params[:username]
  # params = { id: 1 , username: "tom"}

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy
    redirect_to sub_url(post.sub_id)
  end

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end
end
