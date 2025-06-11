library(ellmer)

# Define the structured data specification using ellmer's `type_` functions
fruit_schema <- type_object(
  "A list of fruits and their colors.",
  fruit = type_array(
    items = type_object(
      name = type_string("The name of the fruit."),
      color = type_string("The color of the fruit.")
    )
  )
)

# Create a client object with a specific system prompt
client <- chat_anthropic(
  model = "claude-sonnet-4-20250514",
  system_prompt = "You are a helpful assistant. Always respond in valid JSON format."
)

# Function to get structured response
get_structured_response <- function(prompt) {
  client$chat_structured(
    prompt,
    type = fruit_schema
  )
}

# Example usage
result <- get_structured_response("Give me a list of 3 fruits with their colors")
print(jsonlite::toJSON(result, auto_unbox = TRUE, pretty = TRUE))
