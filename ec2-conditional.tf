#Conditional Expression....it evalutes the condition , if true,it launches 2 ins otherwisw 1
resource "aws_instance" "example" {
  count = var.environment == "prod" ? 2 : 1

  ami           = "ami-0c55b159cbfafe1f0" #change ami 
  instance_type = "t2.micro"

  tags = {
    Name = "${var.environment}-example-instance-${count.index}"
  }
}


# terraform apply -var environment=prod , if u want to create prod env



#more than two environments , you can go for 


# resource "aws_instance" "example" {
#   count = if var.environment == "prod" {
#     1
#   } else if var.environment == "staging" {
#     2
#   } else {
#     0
#   }

#   # other configuration for the instance...
# }
