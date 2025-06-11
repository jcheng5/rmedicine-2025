# Source this file to check if your R environment is set up correctly

local({
  check <- function(condition, msg, action) {
    if (condition) {
      return(TRUE)
    }
    if (missing(action)) {
      message(paste(collapse = "\n", strwrap(msg)))
    } else {
      if (isTRUE(askYesNo(paste(collapse = "\n", strwrap(msg))))) {
        force(action)
      }
    }
    FALSE
  }

  diagnose <- function() {
    repo_dir <- dirname(attr(body(diagnose), "srcfile")$filename)

    TRUE &&
      check(
        "rstudioapi" %in% rownames(installed.packages()),
        "The 'rstudioapi' package is required to run this diagnostic script. Install it?",
        install.packages("rstudioapi")
      ) &&
      check(
        rstudioapi::getActiveProject() == repo_dir,
        "You must open the 'rmedicine-2025' project in RStudio. Open it now?",
        rstudioapi::openProject(repo_dir)
      ) &&
      check(
        getwd() == repo_dir,
        "You must set the working directory to 'rmedicine-2025'. Set it now?",
        setwd(repo_dir)
      ) &&
      check(
        file.exists(".Renviron"),
        "The '.Renviron' file is missing. Create it now?",
        {
          writeLines("ANTHROPIC_API_KEY=your_api_key_here", ".Renviron")
          file.edit(".Renviron")
        }
      ) &&
      check(
        any(grepl(
          "^ANTHROPIC_API_KEY=sk-ant-api03-[\\w\\-]{95}$",
          readLines(".Renviron", warn = FALSE),
          perl = TRUE
        )),
        "The 'ANTHROPIC_API_KEY' in '.Renviron' is not set correctly. Do you have one?",
        file.edit(".Renviron")
      ) &&
      check(
        all(c("ellmer", "shinychat", "shiny", "paws.common", "magick", "beepr") %in% rownames(installed.packages())),
        "Some required packages are missing. Install them now?",
        install.packages(c("ellmer", "shinychat", "shiny", "paws.common", "magick", "beepr"))
      ) &&
      check(
        nzchar(Sys.getenv("ANTHROPIC_API_KEY")),
        "The 'ANTHROPIC_API_KEY' environment variable is not set, even though it is in '.Renviron'. Try restarting R."
      )
  }

  if (diagnose()) {
    cli::cli_alert_success("All checks passed!")
  }
})
