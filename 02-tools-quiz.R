library(ellmer)
library(beepr)

#' Plays a sound effect.
#'
#' @param sound Which sound effect to play.
#' @returns NULL
play_sound <- function(sound = c("correct", "incorrect", "you-win")) {
  sound <- match.arg(sound)
  if (sound == "correct") {
    beepr::beep("coin")
  } else if (sound == "incorrect") {
    beepr::beep("wilhelm")
  } else if (sound == "you-win") {
    beepr::beep("fanfare")
  }
  list(success = TRUE, value = NULL)
}

client <- chat_anthropic(
  model = "claude-sonnet-4-20250514",
  system_prompt = paste(collapse = "\n", readLines("02-tools-prompt.md", warn = FALSE))
)

# Give the chatbot the ability to play a sound.
#
# Created using `ellmer::create_tool_def(play_sound)`
client$register_tool(tool(
  play_sound,
  "Plays a sound effect.",
  sound = type_string(
    "Which sound effect to play. Options are 'correct', 'incorrect', 'you-win'. Defaults to 'correct'.",
    required = FALSE
  )
))

client$chat("Begin", echo = TRUE) # Jump-start the conversation
live_console(client, quiet = TRUE) # Continue the conversation
