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
end
