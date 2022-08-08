package test

import (
	"fmt"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// Testing if the s3 bucket was created and files were uploaded to AWS S3.
func TestTerraformAxeTradingResourcesConfiguration(t *testing.T) {
	t.Parallel()

	// Provide a name for your S3-bucket
	// in your AWS account
	expectedName := fmt.Sprintf("axetrading-terratest-resource-configuration-%s", strings.ToLower(random.UniqueId()))
	configPaths := []string{"configs", "tests"}

	// Construct the terraform options with default retryable errors to handle the most common retryable errors in
	// terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../examples/upload_yaml_files_to_s3",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"bucket_name":  expectedName,
			"config_paths": configPaths,
		},
	})

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	bucket_name := terraform.Output(t, terraformOptions, "config_bucket_name")
	uploaded_files := terraform.Output(t, terraformOptions, "config_files")
	// Check if the condition are met for the terratest to pass.
	assert.Equal(t, expectedName, bucket_name)
	assert.Contains(t, uploaded_files, "s3://")

}
