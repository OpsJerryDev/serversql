# wait for the SQL Server to come up
sleep 90s

#data generator
for i in {1..10}; do curl -L pseudorandom.name; done > /usr/work/webdata.csv

#run the setup script to create the DB and the schema in the DB
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "Password1!" -i setup.sql

# import the data from the csv file
/opt/mssql-tools/bin/bcp webdata.dbo.webstats in "/usr/work/webdata.csv" -c -t',' -S localhost -U SA -P "Password1!"
