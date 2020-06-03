-- Group hosts by CPU number and sort by their memory size in descending order
SELECT
    info.cpu_number,
    usage.host_id,
    info.total_mem
FROM
    host_info info
    INNER JOIN host_usage usage
    ON info.id = usage.host_id
ORDER BY
    info.cpu_number, info.total_mem DESC;

-- Average used memory in percentage over 5 minute intervals for each host.
SELECT
    usage.host_id,
    info.hostname,
    (SELECT MIN(timestamp) FROM host_usage),
    AVG ((((info.total_mem - usage.memory_free)/info.total_mem::float) * 100)::INTEGER) OVER (
	   PARTITION BY usage.timestamp
	)
FROM
    host_info info
    INNER JOIN host_usage usage
    ON info.id = usage.host_id;
