locals {
  uid            = "${var.name}-${var.env_id}"
  image          = var.image != null ? var.image : fileexists("IMAGE") ? file("IMAGE") : ""
  create_service = var.image != null || fileexists("IMAGE")
}
