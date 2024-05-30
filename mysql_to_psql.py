import re

input_file = 'input_file.sql' # read from cloud storage
output_file = 'output_file.sql' # upload to cloud storage
db_list = []

with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
    for line in infile:
        stripped_line = line.strip().upper()
        if stripped_line.startswith('CREATE DATABASE') or stripped_line.startswith('LOCK') or stripped_line.startswith('UNLOCK'):
            outfile.write('-- ' + line)
        elif stripped_line.startswith('SET SCHEMA'):
            # extract db name
            match = re.search(r"SET SCHEMA\s+'(\w+)'", line, re.IGNORECASE)
            if match:
                db_name = match.group(1)
                print(f"Extracted DB name: {db_name}")
                db_list.append(db_name)
            outfile.write('-- ' + line)
        else:
            outfile.write(line)


with open("db_list.txt", 'w') as outfile:
    for db in db_list:
        outfile.write(db + '\n')