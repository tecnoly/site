resource "heroku_app" "staging" {
  name   = "tecnoly-staging"
  region = "us"
}

resource "heroku_app" "production" {
  name   = "tecnoly"
  region = "us"
}


resource "heroku_pipeline" "this" {
  name = "tecnoly"
}

# Couple apps to different pipeline stages
resource "heroku_pipeline_coupling" "staging" {
  app_id   = heroku_app.staging.id
  pipeline = heroku_pipeline.this.id
  stage    = "staging"
}

resource "heroku_pipeline_coupling" "production" {
  app_id   = heroku_app.production.id
  pipeline = heroku_pipeline.this.id
  stage    = "production"
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
}
