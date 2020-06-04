# Introduction
Cluster Monitoring Agent is an internal tool that 
monitors nodes and servers that are connected via 
a switch and are able to communicate using IPv4 
addresses. It is used to gather information on the 
hardware specification and recourse usage of each 
node in the cluster. This data is stored in an RDBMS 
database in two different tables, one for the host 
information and the other for the host usage. The 
Cluster Monitoring Agent is implemented using a 
combination of bash scripts and SQL queries that 
work in conjunction to gather information and store 
it in a database. The data gathered by the monitoring 
agent will aid the infrastructure team in making 
business decisions regarding future resource planning. 


# Quick Start
- Start a psql instance using psql_docker.sh
``` bash 
./linux_sql/scripts/psql_docker.sh start 
```
- Create tables using ddl.sql
``` bash
psql -h psql_host -U psql_user -d host_agent -f /linux_sql/sql/ddl.sql 
```
- Insert hardware specs data into the db using host_info.sh
``` bash
/linux_sql/scripts/host_info.sh psql_host psql_port db_name psql_user psql_password 
```
- Insert hardware usage data into the db using host_usage.sh
``` bash
/linux_sql/scripts/host_usage.sh psql_host psql_port db_name psql_user psql_password 
```
- Crontab setup
``` bash
# Run command to edit crontab jobs
crontab -e

# Insert below statement into crontab
* * * * * bash [path]/host_usage.sh localhost 5432 host_agent postgres password > /tmp/host_usage.log
```

# Architecture Diagram
Draw a cluster diagram with three Linux hosts, a DB, and agents (use draw.io website). Image must be saved to `assets` directory.

# Database Modeling
Describe the schema of each table using markdown table syntax (do not put any sql code)
- `host_info`
- `host_usage`

## Scripts
Shell script descirption and usage (use markdown code block for script usage)
- psql_docker.sh
- host_info.sh
- host_usage.sh
- crontab
- queries.sql (describe what business problem you are trying to resolve)

## Improvements 
Write at least three things you want to improve 
e.g. 
- Implement a dashboard that allows the user to see the performance of each node at a glance. This can provide a visualization of each computer's usage over 
 time.
-  
- 