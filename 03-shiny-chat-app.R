library(dotenv) # Will read OPENAI_API_KEY from .env file
library(ellmer)
library(shiny)
library(shinychat)

ui <- bslib::page_fluid(
  chat_ui("chat")
)

server <- function(input, output, session) {
  client <- chat_anthropic(
    model = "claude-sonnet-4-20250514",
    system_prompt = "You're a trickster who answers in riddles"
  )

  observeEvent(input$chat_user_input, {
    stream <- client$stream_async(input$chat_user_input)
    chat_append("chat", stream)
  })
}

shinyApp(ui, server)
