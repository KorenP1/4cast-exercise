FROM docker.io/postgis/postgis:16-3.5-alpine AS builder
WORKDIR /build
COPY test.backup .
RUN pg_restore -U postgres -C test.backup -f gis_world_db.sql

FROM docker.io/postgis/postgis:16-3.5-alpine
COPY --from=builder /build/gis_world_db.sql /docker-entrypoint-initdb.d