# test_migration_mysql_psql

## MySQL to PostgreSQL



### Create databases in CloudSQL for PostgreSQL
事先要在 google cloud sql建立 postgresql 個體，並在 ｀db_list` 填入要建立的資料庫名稱
```
bash create_psql_db.sh
```
### Pgloader: Database Migration
`pgloader` 來自 https://github.com/dimitri/pgloader.git
```
cd ./pgloader
make save
bash ../pgloader_migrate.sh
```

以下資料庫未全部轉移成功：
- `trend`
- `kol`: column "kol_id" of relation "kol_pool" does not exist