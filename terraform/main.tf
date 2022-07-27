resource "heroku_pipeline" "pipeline" {
  name = "tecnoly"
}

resource "heroku_review_app_config" "config" {
  pipeline_id           = heroku_pipeline.pipeline.id
  org_repo              = "tecnoly/site"
  automatic_review_apps = true
  base_name             = "tecnoly"

  deploy_target {
    id   = "us"
    type = "region"
  }

  destroy_stale_apps = true
  stale_days         = 5
  wait_for_ci        = true
}
