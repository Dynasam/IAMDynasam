# Important to target the app folder.
# Only work if app is in a package.
# register_service_worker is FALSE, shinyMobile already does it.
# We also don't need to create web dependencies.

remotes::install_github("RinteRface/charpente")
library(charpente)
charpente::set_pwa(
  "inst/app",
  register_service_worker = FALSE,
  create_dependencies = FALSE
)


devtools::load_all()
run_app()

