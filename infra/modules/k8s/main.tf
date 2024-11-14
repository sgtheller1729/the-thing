# Deployment definition
resource "kubernetes_deployment" "sim-app-heller_deployment" {
  metadata {
    name = "sim-app-heller-deployment"
    labels = {
      app = "sim-app-heller"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "sim-app-heller"
      }
    }

    template {
      metadata {
        labels = {
          app = "sim-app-heller"
        }
      }

      spec {
        container {
          name  = "sim-app-heller"
          image = "618889213523.dkr.ecr.ap-northeast-1.amazonaws.com/sim-app-heller:latest"

          port {
            name           = "mqtt"
            container_port = 1883
            protocol       = "TCP"
          }

          port {
            name           = "http"
            container_port = 8080
            protocol       = "TCP"
          }
        }
      }
    }
  }
}

# Service definition
resource "kubernetes_service" "sim-app-heller_http_service" {
  metadata {
    name = "sim-app-heller-http-service"
    labels = {
      app = "sim-app-heller"
    }
    annotations = {
      # Reference the ALB-specific configuration
      "service.beta.kubernetes.io/aws-load-balancer-name"   = var.alb_name
      "service.beta.kubernetes.io/aws-load-balancer-type"   = "alb"
      "service.beta.kubernetes.io/aws-load-balancer-scheme" = "internet-facing"
    }
  }

  spec {
    type = "LoadBalancer"

    port {
      name        = "http"
      port        = 8080
      target_port = 8080
      protocol    = "TCP"
    }

    selector = {
      app = "sim-app-heller"
    }
  }
}

resource "kubernetes_service" "sim-app-heller_mqtt_service" {
  metadata {
    name = "sim-app-heller-mqtt-service"
    labels = {
      app = "sim-app-heller"
    }
    annotations = {
      # Reference the NLB-specific configuration
      "service.beta.kubernetes.io/aws-load-balancer-name"             = var.nlb_name
      "service.beta.kubernetes.io/aws-load-balancer-type"             = "nlb"
      "service.beta.kubernetes.io/aws-load-balancer-scheme"           = "internet-facing"
      "service.beta.kubernetes.io/aws-load-balancer-target-group-arn" = var.mqtt_target_group_arn
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

    selector = {
      app = "sim-app-heller"
    }
  }
}
