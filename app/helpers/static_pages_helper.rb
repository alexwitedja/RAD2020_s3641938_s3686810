module StaticPagesHelper
  @@selected_topics = []
  def toggle_topic(topic)
    # Adds to array if not yet in it. otherwise deletes
    if(!@@selected_topics.include?(topic))
      @@selected_topics.push(topic)
    else
      @@selected_topics.delete(topic)
    end
  end

  def get_selected_topics
    @@selected_topics
  end

  # Returns member with the id passed in as parameter
  def get_user(user_id)
    @user = User.find_by(id: user_id)
  end
end
