import re
import sys
from google.cloud import storage

BUCKET_NAME="test_qsh_cloud_sql_migration"
def process_sql_syntax(input_file, output_file):
    db_list = []
    with open(input_file, 'r', encoding="utf-8") as infile, open(output_file, 'w', encoding="utf-8") as outfile:
        for line in infile:
            # print(line)
            if line.startswith('CREATE DATABASE') or line.startswith('LOCK') or line.startswith('UNLOCK'):
                outfile.write('-- ' + line)
            elif line.startswith('SET SCHEMA'):
                # extract db name
                match = re.search(r"SET SCHEMA\s+'(\w+)'", line, re.IGNORECASE)
                if match:
                    db_name = match.group(1)
                    db_list.append(db_name)
                    print(f"Extract DB name: {db_name}")
                outfile.write('-- ' + line)
            else:
                outfile.write(line)
    return db_list


def split_sql(sql_file, db_list):
    i = 0
    next_db = db_list[i+1]
    current_db_content = []
    with open(sql_file, 'r') as infile:
        for line in infile:
            # 檢查是否遇到新的資料庫段落
            if line == f"-- SQLINES DEMO ***  `{next_db}`":
                # 上傳前一個資料庫的內容
                content = "\n".join(current_db_content)
                current_db = db_list[i]
                upload_db_sql(destination_blob_name=f"{current_db}.sql", data=content)
                print(f"upload {current_db} to {BUCKET_NAME}")
                # 清空當前資料庫內容
                current_db_content = []
                if i < len(db_list) - 1:
                    next_db = db_list[i+1]
                    i += 1
            current_db_content.append(line)
        # 上傳最後一個資料庫的內容
        content = "\n".join(current_db_content)
        current_db = db_list[-1]
        upload_db_sql(destination_blob_name=f"{current_db}.sql", data=content)


def upload_db_sql(destination_blob_name: str, data: list) -> None:
    client = storage.Client()
    bucket = client.bucket(BUCKET_NAME)
    blob = bucket.blob(destination_blob_name)
    blob.upload_from_filename(data, content_type='application/sql')

def output_db_list(db_list):
    with open("db_list.txt", 'w') as outfile:
        for db in db_list:
            outfile.write(db + '\n')


if __name__ == '__main__':
    input_file = sys.argv[1]
    output_file = sys.argv[2]
    db_list = process_sql_syntax(input_file, output_file)
    split_sql(sql_file=output_file, db_list=db_list)
    output_db_list(db_list)