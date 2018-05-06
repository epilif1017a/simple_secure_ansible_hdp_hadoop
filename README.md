# SIMPLE_SECURE_ANSIBLE_HDP_HADOOP
Ansible Playbook to Install a Kerberized Hortonworks Hadoop Cluster with some of the good practices from the documentation (e.g., ambari as non-root, dedicated mysql server, encrypted ambari database)

# Tested Ansible Versions
1) Ansible 2.5.2

# Working Operative Systems
1) CentOS 7

# Requirements:

1) Install python's passlib
2) Take into consideration that the user you create on play "0_prepare_cluster.yml" to administer the cluster and execute the subsequent plays (1_launch_cluster.yml) must have adequate access to read and/or execute files/folders in the playbook.

# General Steps:

1) As root (or as an existing user with escalated privileges on all machines), execute 0_prepare_cluster to configure the ansible controller with extra libraries that will be needed (e.g., passlib), and to create and configure an ssh passwordless cluster administrator.

2) As the cluster administrator created above (or as an existing user with escalated privileges on all machines), execute 1_launch_cluster.yml to configure and launch the cluster components (e.g., java, pre-flight checks, mysql, ambari, kerberos).

# Post-installation Important Recommendations:

1) execute 2_post_ambari_installation.yml to configure some aspects mainly related to security (e.g., generate http secret for SPNEGO). This play does not configure anything related to ambari configurations. You'll have to do it yourself.
2) Configure ambari proxy groups and hosts to use ambari views!!!!
...Services > HDFS > Configs > Advanced core-site
...hadoop.proxyuser.ambari.groups=*
...hadoop.proxyuser.ambari.hosts=*

