require 'spec_helper'

describe Review do

  it { should validate_uniqueness_of(:user_id).scoped_to(:video_id) }

  let(:phil) { Fabricate(:user) }
  let(:video) { Fabricate(:video) }

  it 'should belong to one movie' do
    review = Review.new(body: "Great movie", rating: 4)
    video.reviews << review
    phil.reviews << review

    expect(video.reviews.count).to eq(1)
  end

  it 'should have only one author' do
    review = Review.new(body: "Great movie", rating: 4)
    video.reviews << review
    phil.reviews << review

    expect(phil.reviews.count).to eq(1)
  end


  it 'should have a body' do
    review = Review.new(body: "Great movie", rating: 4)

    expect(review.body).not_to be_blank
  end


  it 'should have a rating that is an integer' do
    review = Review.new(body: "Great movie", rating: 4)

    expect(review.rating).to be_kind_of(Integer)
  end


  context 'when many reviews' do

    it 'should sort from oldest to newest' do
      r1 = Review.create(video: video, user_id: 1, body: "Great movie", rating: 4)
      r1 = Review.create(video: video, user_id: 2, body: "Great movie", rating: 4)
      sad_review = Review.create(video: video, user_id: 3, body: "Sad", rating: 3 )
      expect(video.reviews.first).to eq(sad_review)

    end

  end

end

