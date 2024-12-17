resource "aws_route53_zone" "private_zone" {
  name          = var.dns_name
  vpc {
    vpc_id = var.vpc_id
  }
}

resource "aws_route53_record" "alias_record" {
  zone_id = aws_route53_zone.private_zone.zone_id
  name    = var.sub_dns_name
  type    = var.record_type

  alias {
    name                   = var.alias_name
    zone_id                = var.alias_zone_id
    evaluate_target_health = var.evaluate_target_health
  }
}
