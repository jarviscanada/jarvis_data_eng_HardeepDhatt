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
![architecture diagram](/assets/architecture.png)

# Database Modeling
The database, host_agent, is made up of two tables, host_info which contains the 
hardware specifications of the computer, and host_usage which containes the 
resource usage of the computer. \
The `host_info` table contains the following columns. It is only
executed once as hardware specifications are expected to be constant
- `id`: A unique identifier corresponding to each node in the cluster, automatically incremented every time a new entry is added
- `hostname`: A unique character string that contains the hostname of the corresponding node
- `cpu_number`: The number of CPU cores of the corresponding node
- `cpu_architecture`: The architecture of the CPU of the corresponding node
- `cpu_model`: The CPU model of the corresponding node
- `cpu_mhz`: The clock speed of the CPU of the corresponding node in MHz
- `L2_cache`: The cache size of the corresponding node in kB
- `total_mem`: The amount of RAM of the corresponding node in kB
- `timestamp`: The date and time at which the data was obtained

The `host_usage` table contains information on the resource consumption of the 
current node. It can be collected manually, and given the dynamix nature of computer
resource usage this data is being collected every minute. This table contains the 
following columns.
- `timestamp`: The date and time at which the data was obtained
- `host_id`: The unique identifier corresponding to each node in the cluster, automatically added via the `host_info` table as a foreign key.
- `memory_free`: The amount of free memory in mB of the corresponding node 
- `cpu_idle`: The percentage of CPU time spent in idle of the corresponding node
- `cpu_kernel`: The percentage of CPU time spent running kernel code of the corresponding node
- `disk_io`: The number of disk input and output of the corresponding node
- `disk_available`: The amount of space available on the disk in mB of the corresponding node


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