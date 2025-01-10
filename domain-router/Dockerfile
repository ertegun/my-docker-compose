FROM node:slim
WORKDIR /app
COPY package.json .
COPY index.js .
EXPOSE 80/tcp
RUN npm install
CMD ["npm", "start"]

# docker build -t domain-router .
# docker tag domain-router  erte33/ga-domain-router:latest