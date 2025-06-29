library(httr)
library(ellmer)

# Define weather function
get_weather <- function(latitude, longitude) {
  base_url <- "https://api.open-meteo.com/v1/forecast"

  tryCatch(
    {
      response <- GET(
        base_url,
        query = list(
          latitude = latitude,
          longitude = longitude,
          current = "temperature_2m,wind_speed_10m,relative_humidity_2m"
        )
      )
      rawToChar(response$content)
    },
    error = function(e) {
      paste("Error fetching weather data:", e$message)
    }
  )
}

# Create client instance
client <- chat_anthropic(
  model = "claude-sonnet-4-20250514",
  system_prompt = "You are a helpful assistant that can check the weather. Report results in imperial units."
)

# Register the weather tool
#
# Created using `ellmer::create_tool_def(get_weather)`
client$register_tool(tool(
  get_weather,
  "Fetches weather information for a specified location given by latitude and 
longitude.",
  latitude = type_number(
    "The latitude of the location for which weather information is requested."
  ),
  longitude = type_number(
    "The longitude of the location for which weather information is requested."
  )
))

# Test the client
client$chat("What is the weather in Seattle?")
