import re
import sys

def process_sql_syntax(input_file, output_file):
    db_list = []
    with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
        for line in infile:
            print(line)
            # if line.startswith('CREATE DATABASE') or line.startswith('LOCK') or line.startswith('UNLOCK'):
            #     outfile.write('-- ' + line)
            # elif line.startswith('SET SCHEMA'):
            #     # extract db name
            #     match = re.search(r"SET SCHEMA\s+'(\w+)'", line, re.IGNORECASE)
            #     if match:
            #         db_name = match.group(1)
            #         print(f"Extracted DB name: {db_name}")
            #         db_list.append(db_name)
            #     outfile.write('-- ' + line)
            # else:
            #     outfile.write(line)
    return db_list

def output_db_list(db_list):
    with open("db_list.txt", 'w') as outfile:
        for db in db_list:
            outfile.write(db + '\n')


if __name__ == '__main__':
    input_file = sys.argv[1]
    output_file = sys.argv[2]
    db_list = process_sql_syntax(input_file, output_file)
    # output_db_list(db_list)