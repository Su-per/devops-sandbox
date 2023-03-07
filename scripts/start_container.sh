aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin 850738932707.dkr.ecr.ap-northeast-2.amazonaws.com

docker pull 850738932707.dkr.ecr.ap-northeast-2.amazonaws.com/test:latest

docker run -d -p 80:80 850738932707.dkr.ecr.ap-northeast-2.amazonaws.com/test:latest
