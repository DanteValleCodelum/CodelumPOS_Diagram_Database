# Usa la imagen oficial de PostgreSQL
FROM postgres:15

# Copia el script de inicialización
COPY CodelumPOS_script.sql /docker-entrypoint-initdb.d/

# Opcional: copia un entrypoint o configuraciones adicionales
# COPY custom-postgresql.conf /etc/postgresql/postgresql.conf