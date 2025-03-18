#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo "Starting setup process for Lab 3..."

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo -e "${RED}AWS CLI is not installed. Please install it first.${NC}"
    exit 1
fi

# Check if AWS credentials are configured
if ! aws sts get-caller-identity &> /dev/null; then
    echo -e "${RED}AWS credentials are not configured. Please run 'aws configure' first.${NC}"
    exit 1
fi

# Check if Git is installed
if ! command -v git &> /dev/null; then
    echo -e "${RED}Git is not installed. Please install it first.${NC}"
    exit 1
fi

# Validate CloudFormation template
echo "Validating CloudFormation template..."
if aws cloudformation validate-template --template-body file://../templates/s3-bucket-template.yaml; then
    echo -e "${GREEN}Template validation successful!${NC}"
else
    echo -e "${RED}Template validation failed!${NC}"
    exit 1
fi

# Initialize git repository if not already initialized
if [ ! -d .git ]; then
    echo "Initializing git repository..."
    git init
    git add .
    git commit -m "Initial commit"
fi

echo -e "${GREEN}Setup completed successfully!${NC}"
echo "Next steps for Lab 3:"
echo "1. Create a new repository on GitHub named 'Lab-3'"
echo "2. Add the GitHub repository as remote:"
echo "   git remote add origin https://github.com/YOUR_USERNAME/Lab-3.git"
echo "3. Push your code to GitHub:"
echo "   git push -u origin main"
echo "4. Create a CodePipeline in AWS Console using GitHub as the source"
echo "5. Configure GitHub OAuth token in AWS Console for CodePipeline access" 