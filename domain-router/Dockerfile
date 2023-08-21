# Node.js'in son sürümü temel alınarak bir Docker imajı oluşturun
FROM node:slim
# Uygulamanızın çalışacağı dizini oluşturun
WORKDIR /app
# Gerekli dosyaları kopyalayın
COPY package.json .
COPY index.js .

EXPOSE 80/tcp

# Paketleri yükleyin
RUN npm install
# Uygulamayı çalıştırın
CMD ["npm", "start"]


# docker build -t domain-router .
# docker tag domain-router  erte33/ga-domain-router:latest