require 'spec_helper'

describe Post do
  it "gives you a summary" do
    body = <<-EOS
lorem ipsum blahblahblahblah. omg what a i a banana? woah ok. i told you i
READMORE
would do it and what happened? ok it happened.
    EOS
    post = Post.create(title: "hey", body: body)
    post.summary.should == "lorem ipsum blahblahblahblah. omg what a i a banana? woah ok. i told you i\n"
  end
end
