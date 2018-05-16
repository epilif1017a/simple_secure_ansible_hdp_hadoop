# SIMPLE AND SECURE ANSIBLE HDP HADOOP
Ansible Playbook to Install a Kerberized Hortonworks Hadoop Cluster with some of the good practices from the documentation (e.g., ambari as non-root, dedicated mysql server, encrypted ambari database)

# Tested Ansible Versions
1) Ansible 2.5.2

# Working Operative Systems
1) CentOS 7

# Requirements:

1) Python's passlib should be installed
2) Take into consideration that the user you create/choose on the play "0_prepare_cluster.yml" to administer the cluster and execute the subsequent plays (1_launch_cluster.yml) must have adequate access to read files/folders in the playbook.
3) You have have configured your firewall rules appropriately (e.g., cluster's internal network in trusted zone)

# General Steps:

0) Edit the production inventory file according to the hosts involved in your cluster. For adequate hostnames resolution, you have to configure the host files of the ansible-controller or rely on DNS resolution.

1) As root (or as an existing user with escalated privileges on all machines), execute 0_prepare_cluster.yml to configure the ansible controller with extra libraries that will be needed (e.g., pexpect), and to create and configure an ssh passwordless cluster administrator to simplify ansible administration and future tasks on the cluster. Example:

ansible-playbook -i production 0_prepare_cluster --ask-pass --ask-become-pass

2) As the cluster administrator created above (or as an existing user with escalated privileges on all machines), execute 1_launch_cluster.yml to configure and launch the cluster components (e.g., java, pre-flight checks, mysql, ambari, kerberos). Example:

ansible-playbook -i production 1_launch_cluster.yml --ask-become-pass

Notes: If you do not want to install Kerberos simply comment the line "- import_playbook: 1_6_deploy_kerberos_kdcs.yml" in the 1_launch_cluster.yml file

# Post-installation Important Recommendations:

1) Execute 2_post_ambari_installation.yml to configure some aspects after hadoop installation (as of right now, only generates http secret for SPNEGO). This play does not configure anything related to ambari configurations. You'll have to do it yourself in ambari!

2) Configure ambari proxy groups and hosts to use ambari views (if they are not configured already)!
...Services > HDFS > Configs > Advanced core-site
...hadoop.proxyuser.ambari.groups=*
...hadoop.proxyuser.ambari.hosts=*

