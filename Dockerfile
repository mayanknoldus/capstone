FROM node

WORKDIR /node-app

COPY . ./

RUN npm install --save mysql2 && npm install

EXPOSE 2000

ENV DB_HOST=mysql DB_USER=root DB_PASSWORD=root DB_NAME=user 

CMD ["npm","start"]