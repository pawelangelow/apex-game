FROM node:24-alpine AS build
WORKDIR /app
COPY package.json package-lock.json ./
COPY packages/server/package.json packages/server/
COPY packages/client/package.json packages/client/
RUN npm ci
COPY . .
RUN npm run build && npm prune --omit=dev

FROM node:24-alpine
WORKDIR /app
ENV NODE_ENV=production \
    CLIENT_DIST=/app/packages/client/dist
COPY --from=build /app/node_modules node_modules
COPY --from=build /app/packages/server/package.json packages/server/
COPY --from=build /app/packages/server/dist packages/server/dist
COPY --from=build /app/packages/client/dist packages/client/dist
USER node
EXPOSE 3000
CMD ["node", "packages/server/dist/index.js"]
