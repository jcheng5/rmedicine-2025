library(ellmer)

client <- chat_anthropic(
  model = "claude-3-5-haiku-latest",
  system_prompt = "You are a terse assistant.",
)
client$chat("What is the capital of France?")

# The `client` object is stateful, so this continues the existing conversation
client$chat("What is its most famous landmark?")

live_browser(client)
