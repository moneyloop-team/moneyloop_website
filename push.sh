$(aws ecr get-login --no-include-email --region ap-southeast-2)
docker build -t moneyloop-landing-page/production .
docker tag moneyloop-landing-page/production:latest 861473817728.dkr.ecr.ap-southeast-2.amazonaws.com/moneyloop-landing-page/production:latest
docker push 861473817728.dkr.ecr.ap-southeast-2.amazonaws.com/moneyloop-landing-page/production:latest
