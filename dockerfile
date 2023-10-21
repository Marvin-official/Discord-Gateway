ARG         BUN_VERSION=1.0.7-alpine

## Builder

FROM        oven/bun:$BUN_VERSION as builder

WORKDIR     /app
ADD         . .

RUN         bun install --ignore-optional
RUN         bun build


## Release

FROM        oven/bun:$BUN_VERSION as release

WORKDIR     /app

COPY        --from=builder /app/build /app/build
COPY        package.json bun.lockb ./

RUN         bun install --prod --ignore-optional

CMD         ["bun", "start"]
