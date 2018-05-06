GRANT ALL PRIVILEGES ON *.* TO 'ambari'@'localhost' IDENTIFIED BY '{{ mysql_ambari_pass }}';
{% for host in groups['ambari-servers'] %}
GRANT ALL PRIVILEGES ON *.* TO 'ambari'@'{{ hostvars[host].inventory_hostname }}' IDENTIFIED BY '{{ mysql_ambari_pass }}';
# solve problem with MySQL DNS lookups, which sometimes may not consider FQDNs 
GRANT ALL PRIVILEGES ON *.* TO 'ambari'@'{{ hostvars[host].inventory_hostname.split('.')[0] }}' IDENTIFIED BY '{{ mysql_ambari_pass }}';
{% endfor %}
FLUSH PRIVILEGES;
DROP DATABASE IF EXISTS ambari;
CREATE DATABASE ambari;
USE ambari;
SOURCE /var/lib/ambari-server/resources/Ambari-DDL-MySQL-CREATE.sql;