FROM oven/bun:latest AS base
WORKDIR /app
COPY package.json bun.lock ./

RUN bun install

COPY . .
RUN bun run  build

FROM oven/bun:latest AS release
WORKDIR /app

COPY --from=base /app/node_modules ./node_modules
COPY --from=base /app/package.json ./package.json
COPY --from=base /app/.next ./.next

EXPOSE 3000

CMD ["bun", "start"]
