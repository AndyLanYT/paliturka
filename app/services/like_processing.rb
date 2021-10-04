module LikeProcessing
  def already_liked?(user_id, post_id)
    Like.exists?(user_id: user_id, post_id: post_id)
  end
end
