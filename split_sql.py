import re

input_file = 'your_input_file.sql'
output_dir = 'output_directory'  # 請確保這個目錄存在

current_db = None
current_db_content = []

def write_db_file(db_name, content):
    with open(f"{output_dir}/{db_name}.sql", 'w') as db_file:
        db_file.writelines(content)

with open(input_file, 'r') as infile:
    for line in infile:
        # 檢查是否遇到新的資料庫段落
        match = re.match(r"-- SQLINES DEMO \*\*\*  `(\w+)`", line)
        if match:
            # 如果當前有資料庫，則將其內容寫入檔案
            if current_db:
                write_db_file(current_db, current_db_content)
                current_db_content = []
            # 更新當前資料庫名稱
            current_db = match.group(1)
        if current_db:
            current_db_content.append(line)
    
    # 將最後一個資料庫的內容寫入檔案
    if current_db:
        write_db_file(current_db, current_db_content)

print("SQL files have been split and saved.")
