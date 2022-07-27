terraform {
  required_providers {
    heroku = {
      source  = "heroku/heroku"
      version = "5.1.1"
    }
    herokux = {
      source  = "davidji99/herokux"
      version = "0.33.7"
    }
  }
  required_version = "~> 1.2.6"
}
