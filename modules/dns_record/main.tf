terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_token
}

resource "cloudflare_dns_record" "lb_static_ip_dns_record" {
  zone_id = var.cloudflare_zone_id
  name    = var.domain
  ttl     = 1
  type    = "A"
  comment = "${var.environment} lb static ip dns record"
  content = var.lb_static_ip
  proxied = true

  depends_on = [var.lb_static_ip_resource_name]
}