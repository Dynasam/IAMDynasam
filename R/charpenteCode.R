# Important to target the app folder.
# Only work if app is in a package.
# register_service_worker is FALSE, shinyMobile already does it.
# We also don't need to create web dependencies.

install.packages("remotes")
library(remotes)
devtools::install_github("RinteRface/charpente")

library(charpente)
charpente::set_pwa(
  "inst/app",
  register_service_worker = FALSE,
  create_dependencies = FALSE
)

#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
# usethis::gh_token_help()
# gitcreds::gitcreds_set()
# devtools::load_all()
#
# run_app()

