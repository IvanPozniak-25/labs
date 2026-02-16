## Terraform 
1. Create main.tf file with vpc, subnet, and ec2 instance resources.
2. terraform init![TerraformInit.png](images/TerraformInit.png)
3. Terraform plan ![TerraformPlan.png](images/TerraformPlan.png)![TerraformPlan2.png](images/TerraformPlan2.png)
4. terraform apply ![TerraformApply.png](images/TerraformApply.png)![TerraformApply.png](images/TerraformApply.png)
5. Verify es2 in AWS Console ![AWSConsole.png](images/EC2AWSConsole.png)
6. Verify vpc and subnet in AWS Console ![VPCAWSConsole.png](images/VPCAWSConsole.png)
7. Create sub dir for terrafrom import and create import.tf with  ec2 instance resources.
8. Run terrafrom import command to import existing ec2 instance into terraform state. ![TerraformImport.png](images/TerraformImport.png)
9. 