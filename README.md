# Graphite SQL Connector

Send custom SQL queries into Graphite to visualize your database tables over time.

### Installation

1. Clone this repo.
2. `cp config.sh.example config.sh`
3. Configure your database and Graphite endpoint in the `config.sh` file.
4. Write your SQL queries in the `queries/` folder
4. Run it using `./collect.sh`.
5. Watch your metrics roll into your preferred visualizer (e.g. Grafana)

### Queries

Graphite requires the labeling the metrics you export. Therefor, query results are expected in two columns: the timeseries name and the actual value.

Optionally, you can add the interval (in seconds) at which the metrics can be expected as a third column. 

Beware that, when combining many queries with a `UNION` statement, they must all have the interval column.

### Scheduling

- crontab
- system.d

### Points to optimize

- Currently it opens a new MySQL session and a new HTTP session to your Graphite endpoint for every SQL file in the `queries` folder
- Don't pass the MySQL password as argument.
