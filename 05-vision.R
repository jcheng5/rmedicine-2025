library(ellmer)

client <- ellmer::chat_anthropic(model = "claude-sonnet-4-20250514")

client$chat(
  "What photographic choices were made here, and why do you think the photographer chose them?",
  content_image_file("photo.jpg")
)

client$chat("Come up with an artsy, pretentious, minimalistic, abstract title for this photo.")
