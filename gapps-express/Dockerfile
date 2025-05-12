# Node.js'in son sürümü temel alınarak bir Docker imajı oluşturun
FROM node:lts-alpine3.21
# Uygulamanızın çalışacağı dizini oluşturun
WORKDIR /app
# Gerekli dosyaları kopyalayın
# COPY package.json .
# COPY index.js .
COPY . .

EXPOSE 6499/tcp

# Paketleri yükleyin
RUN npm install
# Uygulamayı çalıştırın
CMD ["npm", "start"]


# docker build -t gapps-express .
# docker tag gapps-express  erte33/gapps-express:latest
# docker push erte33/gapps-express:latest
# docker run -d -p 6499:6499 erte33/gapps-express:latest