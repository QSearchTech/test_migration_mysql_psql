import re
import sys
from google.cloud import storage

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


def split_sql_file(sql_file, db_list):
    i = 0
    current_db = db_list[i]
    next_db = db_list[i+1]
    current_db_content = []
    with open(sql_file, 'r', encoding="utf-8") as infile:
        for line in infile:
            # 檢查是否遇到新的資料庫段落
            check_point = f"-- SQLINES DEMO ***  `{next_db}`"
            if check_point in line:
                # print(current_db, next_db)
                # 上傳前一個資料庫的內容
                out_path = f"sql_files/{current_db}.sql"
                write_out_file(content=current_db_content, out_path=out_path)
                print(f"Output sql_files/{current_db}.sql")
                # 清空當前資料庫內容
                current_db_content = []
                if (i+2) < len(db_list):
                    i += 1
                    current_db = next_db
                    next_db = db_list[i+1]
            current_db_content.append(line)
        # 上傳最後一個資料庫的內容
        current_db = db_list[-1]
        out_path = f"sql_files/{current_db}.sql"
        write_out_file(content=current_db_content, out_path=out_path)
        print(f"Output sql_files/{current_db}.sql")


def write_out_file(content, out_path):
    with open(out_path, 'w') as outfile:
        for line in content:
            if "db_list" in out_path:
                outfile.write(line + '\n')
            else:
                outfile.write(line)


if __name__ == '__main__':
    input_file = sys.argv[1]
    output_file = sys.argv[2]
    db_list = process_sql_syntax(input_file, output_file)
    print(f"Output {output_file}")
    split_sql_file(sql_file=output_file, db_list=db_list)
    write_out_file(content=db_list, out_path="db_list.txt")
    print(f"Output db_list.txt")