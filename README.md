# R/Medicine 2025 Workshop: Demystifying LLMs with Ellmer

1. Clone this repo [https://github.com/jcheng5/rmedicine-2025](https://github.com/jcheng5/rmedicine-2025)
2. Open the repo in RStudio as a project, or in Positron as a folder
3. Grab your Anthropic key by going to: \
[https://beacon.joecheng.com](https://beacon.joecheng.com) \
and save it to `.Renviron`
4. Install required packages

```{.r}
install.packages(c("ellmer", "shinychat", "shiny", "paws.common",
  "magick", "beepr"))
```

5. Restart R
