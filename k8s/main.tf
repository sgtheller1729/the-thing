# Deployment definition
resource "kubernetes_deployment" "the_thing_app_heller_deployment" {
  metadata {
    name = "the-thing-app-heller-deployment"
    labels = {
      app = "the-thing-app-heller"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "the-thing-app-heller"
      }
    }

    template {
      metadata {
        labels = {
          app = "the-thing-app-heller"
        }
      }

      spec {
        container {
          name  = "the-thing-app-heller"
          image = "618889213523.dkr.ecr.ap-northeast-1.amazonaws.com/the-thing-app-heller:latest"

          port {
            container_port = 1883
          }
        }
      }
    }
  }
}

# Service definition
resource "kubernetes_service" "the_thing_app_heller_service" {
  metadata {
    name = "the-thing-app-heller-service"
    labels = {
      app = "the-thing-app-heller"
    }
    annotations = {
      # Reference the NLB name and target groups from remote state
      "service.beta.kubernetes.io/aws-load-balancer-name" = data.terraform_remote_state.infra.outputs.nlb_name

      "service.beta.kubernetes.io/aws-load-balancer-target-group-arn" = jsonencode([
        data.terraform_remote_state.infra.outputs.mqtt_target_group_arn,
        data.terraform_remote_state.infra.outputs.html_target_group_arn
      ])

      # Other annotations for NLB
      "service.beta.kubernetes.io/aws-load-balancer-type"   = "nlb"
      "service.beta.kubernetes.io/aws-load-balancer-scheme" = "internet-facing"
    }
  }

  spec {
    type = "LoadBalancer"

    port {
      name        = "mqtt"
      port        = 1883
      target_port = 1883
      protocol    = "TCP"
    }

    port {
      name        = "http"
      port        = 8080
      target_port = 8080
      protocol    = "TCP"
    }

    selector = {
      app = "the-thing-app-heller"
    }
  }
}
