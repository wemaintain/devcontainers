withPg() {
  local host=wemaintain-pgsql-staging.cdtgkxemrw9j.eu-west-1.rds.amazonaws.com
  local user=backend_dev
  local password
  password=$(aws rds --profile prod:back generate-db-auth-token --hostname "$host" --port 5432 --region eu-west-1 --username "$user")
  DB_HOST=$host \
  POSTGRES_HOST=$host \
  DB_USER=$user \
  POSTGRES_USERNAME=$user \
  DB_PASSWORD=$password \
  POSTGRES_PASSWORD=$password \
  DB_SSL_CA=/usr/local/share/aws/rds-ca-cert.pem \
  "$@"
}
