atom_feed({'xmlns:app' => 'http://www.w3.org/2007/app',
      'xmlns:openSearch' => 'http://a9.com/-/spec/opensearch/1.1/'}) do |feed|
    feed.title("BlogPress Sourav")
    feed.updated((@articles.first.created_at.to_datetime))
    feed.tag!('openSearch:totalResults', 5)

  @articles.each do |post|
    feed.entry(post) do |entry|
      entry.title(post.title)
      entry.content(post.body, type: 'html')
      entry.tag!('app:edited', post.updated_at.to_datetime.rfc3339)

      entry.author do |author|
        author.name("Sourav")
      end
    end
  end
end
