FROM node:20 AS frontend-builder
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ ./
RUN npm run build
FROM node:20 AS backend
WORKDIR /app/backend

COPY backend/package*.json ./
RUN npm install
RUN npm install -g pm2

COPY backend/ ./

COPY --from=frontend-builder /app/frontend/dist /app/frontend/dist

EXPOSE 80
CMD ["pm2-runtime", "server.js"]
