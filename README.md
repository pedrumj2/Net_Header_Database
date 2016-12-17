# Network Header Database
This git has been implemented for the purpose of adding network header options into a database. When you have large amounts of packet traces
working with them in simple text files will no longer be possible and it will be required to work with in a structure format. The input
to the scripts in this project are from [this](https://github.com/pedrumj2/Pcap_Extractor) previous project.

# Usage
=========================
Create a file and name it `.config`. Enter the following six lines into this file:
```bash
#                                       (The first 2 lines are comments)
#                                       (some more comment)
#pass:pas\\$word                        (password of root right after the colon. Note that special characters must be escaped)
#database:mydb                          (the name of the database)
#CSV location:../Source_Files/CSV       (The location of the CSV file)
#                                       (an empty line which is required)
```

Call the wrapper script with the name of any other script to execute the respective script. The wrapper will read the config
details from the `.config` file and call the respective script with the correct arguments.

```bash
$ ./wrapper.sh process_csv.sh
```
# imp_csv.sh
=========================
Imports the CSV file into the database. It creates a table with the name of the CSV file if it does not already exist. It read 
the csv files headers and generate the table accordingly

```bash
$ ./wrapper.sh imp_csv.sh
```

# clear_db.sh
=========================
1- Drops the packet table and recreates it. This is to avoid deleting records one by one which will take much longer
2- Deletes records from the macaddr table and creates a dummy record with ID 1
3- Deletes records from the ipaddr table and creates a dummy record with ID 1

```bash
$ ./wrapper.sh clear_db.sh
```


# process_cvs.sh
=========================
Reads the packets from the CSV table and adds them to the packet table making lookups for the Ip and mac address

```bash
$ ./wrapper.sh process_cvs.sh
```
