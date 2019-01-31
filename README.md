# SIMPLE AND SECURE ANSIBLE HDP HADOOP
Ansible Playbook to Install a Kerberized Hortonworks Hadoop Cluster with some of the good practices from the documentation (e.g., ambari as non-root, dedicated mysql server, encrypted ambari database)

# Tested Ansible Versions
1) Ansible 2.7

# Working Operative Systems
1) CentOS 7

# Requirements:

1) Python's passlib should be installed on the ansible controller executing the playbook.
2) You have have configured your network (e.g., DNS or hosts file in the ansible controller running this playbook) and firewall rules appropriately (e.g., cluster's internal network in trusted zone), and changed the network prefix in ${PLAYBOOK_HOME}groups_vars/all.yml (important!!!).
3) You have checked the variables in ${PLAYBOOK_HOME}/group_vars/ambari.yml to check the version of the ambari server and mysql connector, as well as the version of the jdk and mysql server roles in ${PLAYBOOK_HOME}/roles/java|mysql/vars.

# General Steps:

0) Edit the production inventory file according to the hosts involved in your cluster. For adequate hostnames resolution, you have to configure the host files of the ansible-controller or rely on DNS resolution.

1) As root (or as an existing user with escalated privileges on all machines), execute 0_prepare_cluster.yml to configure the ansible controller with extra libraries that will be needed (e.g., pexpect), and to create and configure an ssh passwordless cluster administrator to simplify ansible administration and future tasks on the cluster. Example:

```
ansible-playbook -i production 0_prepare_cluster.yml --ask-pass --ask-become-pass
```

2) As the cluster administrator created above (important!!! because this new user is the new owner of the playbook folder), execute 1_launch_cluster.yml to configure and launch the cluster components (e.g., java, mysql, ambari, kerberos). Notes: If you do not want to install Kerberos simply comment the line "- import_playbook: 1_6_deploy_kerberos_kdcs.yml" in the 1_launch_cluster.yml file. Example:

```
ansible-playbook -i production 1_launch_cluster.yml --ask-become-pass
```

3) Proceed to configure an HDP cluster via the Ambari Web page. Note: choose manual agent registration!!!

# Post-installation Important Recommendations:

1) Execute 2_post_ambari_installation.yml to configure some aspects after hadoop installation (as of right now, only generates http secret for SPNEGO). This play does not configure anything related to ambari configurations. You'll have to do it yourself in ambari!

