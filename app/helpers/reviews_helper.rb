MAX_RATING = 5
module ReviewsHelper
  def display_stars(review)
    full_stars = review.rating
    empty_stars = MAX_RATING - full_stars
    "#{('★' * full_stars)}#{'☆' * empty_stars}"
  end
end