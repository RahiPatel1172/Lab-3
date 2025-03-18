# Lab 3: Automated Infrastructure Deployment with AWS CloudFormation and CodePipeline

This is Lab 3 of the course, demonstrating automated infrastructure deployment using AWS CloudFormation and CodePipeline.

## Project Structure

```
.
├── templates/
│   └── s3-bucket-template.yaml    # CloudFormation template for S3 bucket
├── scripts/                       # Additional scripts (if needed)
└── README.md                      # This file
```

## Prerequisites

- AWS CLI installed and configured
- AWS Account with appropriate permissions
- Git installed
- GitHub account
- GitHub OAuth token for AWS CodePipeline

## Setup Instructions

1. **Validate CloudFormation Template**
   ```bash
   aws cloudformation validate-template --template-body file://templates/s3-bucket-template.yaml
   ```

2. **Set Up GitHub Repository**
   - Create a new repository on GitHub
   - Initialize and push your code:
     ```bash
     git init
     git add .
     git commit -m "Initial commit"
     git remote add origin <your-github-repo-url>
     git push -u origin main
     ```

3. **Configure GitHub OAuth Token**
   - Go to GitHub Settings > Developer Settings > Personal Access Tokens
   - Generate a new token with 'repo' scope
   - Save the token securely

4. **Configure CodePipeline**
   - Go to AWS Console > CodePipeline
   - Create a new pipeline
   - Configure the following stages:
     - Source:
       - Provider: GitHub (Version 2)
       - Connection: Create new connection using your GitHub OAuth token
       - Repository: Select your GitHub repository
       - Branch: main
     - Deploy:
       - Provider: AWS CloudFormation
       - Action mode: Create or update stack
       - Stack name: infrastructure-stack
       - Template path: templates/s3-bucket-template.yaml
       - Capabilities: CAPABILITY_IAM

5. **Test the Pipeline**
   - Make changes to the template
   - Push changes to GitHub to trigger the pipeline
   - Verify the deployment in AWS Console

## Template Parameters

- `BucketName`: Name of the S3 bucket (default: my-unique-bucket-name-123)
- `EnableVersioning`: Enable/disable versioning (default: true)

## Cleanup

To avoid unwanted costs, delete the CloudFormation stack after testing:
```bash
aws cloudformation delete-stack --stack-name your-stack-name
```

## Grading Criteria

- Correct CloudFormation Template (20%)
- Proper Setup and Connection of GitHub to CodePipeline (20%)
- CodePipeline Stages Setup and Automated Trigger (20%)
- Successful Deployment and Verification (20%)
- Resource Cleanup and Documentation (20%) 