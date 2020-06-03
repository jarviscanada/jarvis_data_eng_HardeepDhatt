-- Group hosts by CPU number and sort by their memory size in descending order
SELECT
    info.cpu_number,
    usage.host_id,
    info.total_mem
FROM
    host_info info
    INNER JOIN host_usage usage
    ON info.id = usage.host_id
GROUP BY
    info.cpu_number
ORDER BY
    info.total_mem;

-- Average used memory in percentage over 5 minute intervals for each host.
