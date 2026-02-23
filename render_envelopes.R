library(yaml)

sender <- c("John Doe", "123 Main Street", "Springfield, IL 62701")

recipients <- read.csv("data/recipients.csv", stringsAsFactors = FALSE)
dir.create("output", showWarnings = FALSE)

for (i in seq_len(nrow(recipients))) {
  r <- recipients[i, ]

  recipient <- c(
    paste(r$first_name, r$last_name),
    r$adresse,
    paste(r$zip, r$city)
  )
  slug <- tolower(gsub(" ", "_", paste0(r$first_name, "_", r$last_name)))
  output_file <- file.path("output", paste0("envelope_", slug, ".pdf"))

  tmp_yaml <- tempfile(fileext = ".yaml")
  write_yaml(list(sender = as.list(sender), recipient = as.list(recipient)), tmp_yaml)
  on.exit(unlink(tmp_yaml), add = TRUE)

  message("Rendering: ", output_file)
  system2("quarto", c(
    "render", "template-batch.qmd",
    "--output", basename(output_file),
    "--metadata-file", tmp_yaml
  ))
  if (file.exists(basename(output_file))) {
    file.rename(basename(output_file), output_file)
  }
}

message("Done. PDFs written to output/")
