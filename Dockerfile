FROM node:alpine AS builder

RUN npm i -g yarn

WORKDIR /app
COPY package.json .
COPY yarn.lock .
RUN yarn
COPY . .
RUN yarn build

FROM nginx AS runner
WORKDIR /app
COPY --from=builder /app/build /usr/share/nginx/html
