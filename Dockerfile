

from node:20-alpine as frontend-running
copy frontend/package*.json ./
run npm install
copy frontend/ ./
run npm run build

from node:20-alpine as frontend-running
workdir /app/backend
copy backend/package*.json ./
RUN npm install
run npm install -g pm2
copy backend/ ./
copy --from=frontend-builder /app/frontend/dist /app/frontend/dist
expose 80
CMD ["pm2-runtime", "server.js"]