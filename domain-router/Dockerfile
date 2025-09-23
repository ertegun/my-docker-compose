FROM node:slim
WORKDIR /app
COPY package.json .
COPY index.js .
COPY meta.gruparge.com ./meta.gruparge.com
EXPOSE 80/tcp
RUN npm install
CMD ["npm", "start"]

# docker build -t erte33/ga-domain-router:latest .
# docker run -d -p 80:80 --name domain-router --restart always erte33/ga-domain-router:latest