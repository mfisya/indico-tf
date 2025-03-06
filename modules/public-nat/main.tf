 resource "aws_eip" "nat" {
    
     tags = {
         Name = "public-nat-eip"
     }
 }

 resource "aws_nat_gateway" "public_nat" {
   allocation_id = aws_eip.nat.id
   subnet_id     = var.public_subnet_id

   tags = {
     Name = "public-nat-gateway"
   }
 }
