require 'spec_helper'

describe Podcast do
  it 'attaches an mp3' do
    VCR.use_cassette 'podcast_upload' do
      p = Podcast.new pub_date: Date.current
      p.mp3 = File.open('spec/fixtures/test.mp3')
      p.save!
    end
  end
end
