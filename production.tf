# # todo: vpc, eks, rds,
# # secgroup
# # route table
# # public nat
# # private nat
# # private subnet
# # ec2 runner

# module "security_group_id" {
#   source = "./modules/sg-prod"
#   vpc_id = module.vpc_hub.vpc_id
  
# }

# module "route_table_id" {
#     source = "./modules/rtb-prod"
#     vpc_id = module.vpc_hub.vpc_id

#     routes = [
#         {
#             cidr_block = "0.0.0.0/0"
#             gateway_id = "igw-12345678"
#         }
#     ]
# }