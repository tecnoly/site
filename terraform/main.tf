resource "heroku_pipeline" "this" {
  name = "tecnoly"
}

resource "herokux_pipeline_github_integration" "this" {
  pipeline_id = heroku_pipeline.this.id
  org_repo    = "tecnoly/site"
}

resource "heroku_review_app_config" "this" {
  pipeline_id           = heroku_pipeline.this.id
  org_repo              = herokux_pipeline_github_integration.this.org_repo
  automatic_review_apps = true
  base_name             = heroku_pipeline.this.name

  deploy_target {
    id   = "us"
    type = "region"
  }

  destroy_stale_apps = true
  stale_days         = 5
  wait_for_ci        = true
}
