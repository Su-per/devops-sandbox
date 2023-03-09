export AWS_DEFAULT_REGION=`aws ssm get-parameters --names "/CodePipeline/AWS_DEFAULT_REGION" --query Parameters[*].Value --output text --region ap-northeast-2`
export AWS_ACCOUNT_ID=`aws ssm get-parameters --names "/CodePipeline/AWS_ACCOUNT_ID" --query Parameters[*].Value --output text --region ap-northeast-2`
export IMAGE_REPO_NAME=`aws ssm get-parameters --names "/CodePipeline/IMAGE_REPO_NAME" --query Parameters[*].Value --output text --region ap-northeast-2`
export IMAGE_TAG=`aws ssm get-parameters --names "/CodePipeline/IMAGE_TAG" --query Parameters[*].Value --output text --region ap-northeast-2`

aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com

docker pull $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$IMAGE_REPO_NAME:$IMAGE_TAG

docker run -d -p 80:80 $AWS_ACCOUNT_ID.dkr.ecr.ap-northeast-2.amazonaws.com/$IMAGE_REPO_NAME:$IMAGE_TAG
