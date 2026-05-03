#### I expect that you already have private key in the same dir where tf-files are located, so generate public key with below command:

ssh-keygen -y -f /path/to/private_key > public_key.pub

### To test, run:
terraform plan -var-file=prod.tfvars 
