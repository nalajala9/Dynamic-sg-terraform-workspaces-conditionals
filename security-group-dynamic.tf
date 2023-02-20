locals {
   ingress_rules = [{
      port        = 443
      description = "Ingress rules for port 443"
   },
   {
      port        = 80
      description = "Ingree rules for port 80"
   }]
}

resource "aws_security_group" "main" {
   name   = "resource_with_dynamic_block - ${terraform.workspace}" # terraform variabale which prints current workspace name 
   vpc_id = data.aws_vpc.main.id

   dynamic "ingress" {
      for_each = local.ingress_rules     #for_each only works with type map and set.To access value you can use each.value

      content {
         description = ingress.value.description
         from_port   = ingress.value.port
         to_port     = ingress.value.port
         protocol    = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
      }
   }

   egress {
   from_port        = 0
   to_port          = 0
   protocol         = "-1"
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
}
   tags = local.common_tags
}


locals {
# Common tags to be assigned to all resources of type map
common_tags = {
   Name = "AWS security group dynamic block-${terraform.workspace}"
   Service = "Business"
   Owner   = "Ravi" 
   Environment= "${terraform.workspace}"
}
}


# terraform workspace new dev , creates new workspace
# terraform workspace show , Show the name of the current workspace.
# terraform workspace select <workspace-name> , switching b/w workspaces
# terraform workspace list ,  List Terraform workspaces.
# terraform workspace delete dev, to delete dev > switch to other workspace... Delete a Terraform workspace