FROM node:alpine as builder
WORKDIR "/var/app"
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# The following does nothing in our DEV environment. We would still need to map
# port 80 manually when we docker run. However, this directive is import for
# AWS elasticbeanstalk because it uses it to setup its own port mapping
EXPOSE 80 
COPY --from=builder /var/app/build /usr/share/nginx/html
