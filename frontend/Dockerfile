# Stage 1: Build
# ✅ استخدم Node 22 لأن Vite يحتاج Node 20+
FROM node:22 AS build

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# نحذف ملفات الاختبار قبل البناء داخل Docker
RUN find src -type f -name "*.test.ts*" -delete

RUN npm run build

# Stage 2: Run
# ✅ هنا أيضًا نستخدم Node 22-slim
FROM node:22-slim
WORKDIR /app
COPY --from=build /app/dist ./dist
COPY package*.json ./
# ✅ نخلي vite متوفر للتشغيل
RUN npm install

EXPOSE 4173
CMD ["npm", "run", "preview", "--", "--host", "0.0.0.0"]

