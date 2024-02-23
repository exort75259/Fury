ARG NODE_VERSION=20
FROM node:${NODE_VERSION}
RUN adduser --disabled-password app
WORKDIR /app
COPY package*.json ./
RUN npm install

RUN chown -R app:app /app

COPY . .
ARG PORT=5000
ENV PORT=${PORT}

EXPOSE ${PORT}

LABEL maintainer=" <exort@com.ua>"
LABEL version="1.0"
LABEL description="Node.js application"
USER app

LABEL version="latest"

CMD ["node", "app.js"]

# команды билда образов с тегами docker build --build-arg NODE_VERSION=latest -t nodejs-app:latest . 
# docker build --build-arg NODE_VERSION=20 -t nodejs-app:20 .
# docker run --rm -it nodejs-app:latest /bin/bash затем printenv для проверки переменных и exit
# docker run --rm -it -p 8000:5000 -e PORT=5000 nodejs-app:latest тут я поменял порт через енвайронмент
# docker build --build-arg PORT=8000 -t nodejs-app . 
# docker run --rm -d -p 8000:8000 nodejs-app для запуска контейнера , а затем docker inspect nodejs-app для просмотра лейблов
 





ENTRYPOINT /usr/src/app/date.txt
