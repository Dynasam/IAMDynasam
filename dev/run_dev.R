# Set options here
options(golem.app.prod = FALSE) # TRUE = production mode, FALSE = development mode

# Detach all loaded packages and clean your environment
golem::detach_all_attached()
# rm(list=ls(all.names = TRUE))

# Document and reload your package
golem::document_and_reload()

# Run the application
run_app()

# usethis::create_github_token()
# gitcreds::gitcreds_set()
# #"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")
# usethis::gh_token_help()
# gh::gh_whoami()

devtools::load_all()
run_app()
