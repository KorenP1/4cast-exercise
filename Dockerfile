FROM docker.io/postgres:16.6-alpine AS builder
WORKDIR /build
COPY test.backup .
RUN pg_restore -U postgres -C -F c test.backup -f gis_world_db.psql

FROM docker.io/postgres:16.6-alpine
COPY --from=builder /build/gis_world_db.psql /docker-entrypoint-initdb.d