GRANT ALL PRIVILEGES ON *.* TO 'hive'@'localhost' IDENTIFIED BY '{{ mysql_hive_pass }}';
{% for host in groups['hive-servers'] %}
GRANT ALL PRIVILEGES ON *.* TO 'hive'@'{{ hostvars[host].inventory_hostname }}' IDENTIFIED BY '{{ mysql_hive_pass }}';
# solve problem with MySQL DNS lookups, which sometimes may not consider FQDNs 
GRANT ALL PRIVILEGES ON *.* TO 'hive'@'{{ hostvars[host].inventory_hostname.split('.')[0] }}' IDENTIFIED BY '{{ mysql_hive_pass }}';
{% endfor %}
FLUSH PRIVILEGES;
DROP DATABASE IF EXISTS hive;
CREATE DATABASE hive;