alias withPg='DB_HOST=wemaintain-pgsql-staging.cdtgkxemrw9j.eu-west-1.rds.amazonaws.com DB_USER=backend_dev DB_PASSWORD=$(aws rds --profile prod:back generate-db-auth-token --hostname wemaintain-pgsql-staging.cdtgkxemrw9j.eu-west-1.rds.amazonaws.com --port 5432 --region eu-west-1 --username backend_dev)'

