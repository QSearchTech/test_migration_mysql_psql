# test_migration_mysql_psql
將 MySQL (Cloud SQL) 複製遷移至現存的 PostgreSQL (Cloud SQL)

## MySQL to PostgreSQL
事先要在 google cloud sql 建立 postgresql 個體，並在 `db_list.txt` 手動填入要遷移的資料庫名稱，
然後使用 pgloader (https://github.com/dimitri/pgloader.git) 與 gcloud 指令來遷移資料庫。
```
cd ./pgloader
make save
bash ../db_migration.sh
```

## Database
- project: master-experiment
- MySQL instance: `mysql-migrate` (資料源：`qsearch-sql-dev`)
  - MYSQL_HOST="34.42.234.145"
  - MYSQL_USER="qsh"
  - MYSQL_PASSWORD="Q/VMy)Xj2[\I_|Jx"
- PostgreSQL instance: `qsearch-psql`
  - PSQL_HOST="35.239.118.199"
  - PSQL_USER="postgres"
  - PSQL_PASSWORD="LwejnHswdj"


## Result
以下資料庫出現無法處理的pgloader error，未全部轉移成功：
- `bundle`
- `kol`
- `trend`
