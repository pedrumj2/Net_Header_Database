# Network Header Database
This git has been implemented for the purpose of adding network header data into a database. When you have large amounts of packet traces
working with them in simple text files will no longer be possible and it will be required to work with in a structure format. 

# usage
The general ways of calling the scripts are:
```
./script.sh <password> <database> <file>
```


```
./script.sh <password> <database>
```

The script will correct you if you did not provide enough input arguements.

# clear_db.sh
Drops all tables form the database. Used if trying to restart database.

# imp_csv.sh
Imports a CSV file into the database. It creates a table with the name of the CSV file if it does not already exist. It reads 
the csv file's headers and creates a column for each header.

# initDB.sh
Initiates the database by creating empty tables with appropriate columns

# process_cvs.sh
Reads the packets from the CSV table and adds records to the tables in the database accordingly. It finds unique IP and mac values and adds them to the ipaddr and macaddr tables and links their ids back to the packet table. 
