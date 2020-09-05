eksctl create cluster \
--name capstoneclusterspflash \
--version 1.16 \
--nodegroup-name standard-workers \
--node-type t2.medium \
--nodes 3 \
--nodes-min 1 
--nodes-max 4 \
--node-ami auto \
--region us-west-2