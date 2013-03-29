module PostsHelper
  def show_body(post)
    post.body.gsub(/READMORE/,'')
  end
end
