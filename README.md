### Openresty installation from source and dockerizing

## Assumptions
* [Bolt](https://puppet.com/docs/bolt)is installed

## Procedure followed

* Used ubuntu xenial for the entire case study, because I am familiar with ubuntu linux distribution
* Terraform was used to setup the underlying layer.
* Terraform version used was 0.11.1
* Puppet and other necessary packages were installed using bootstrap scripts
* Ran puppet in stand alone mode
* Downloaded openresty from github source,packaged and installed the application using puppet
* Installed docker using puppet
* Added the manifests to the repository
* Dockerized the whole solution and build the docker container
* To monitor the application used [StatusCake](https://www.statuscake.com/) which will monitor the application every one minute.

## To stop and start openresty service running inside container
* Assuming bolt is installed
* Will forward the ssh key and IP address through Email.
* Add the bolt.yml file present in the repository under `~/.puppetlabs/bolt.yml`
* And make sure that the ssh key is available under `~/.ssh/deploy_rsa`
* To stop the service
``` bolt command run --nodes=${ip_address} --user=ubuntu 'sudo docker exec ak-openresty /usr/local/openresty/bin/openresty -s quit' ```
* To stop the service
``` bolt command run --nodes=${ip_address} --user=ubuntu 'sudo docker exec ak-openresty /usr/local/openresty/bin/openresty' ```
* The alerting email will take up to 1 min  to reach the mailbox after shutting the service

# Improvements
 * It would be better to use r10k for puppet deployment. But considering the length and time of the task didn't use it.
 * Instead of bolt, we can use travis-ci(tried it though, but the user needs write access to the repository)
 * We can use Docker API to start and stop a service running on remote hosts and example configuration is
 * Add this configuration in /etc/systemd/system/docker.service.d/override.conf and restart the docker service

    ```
    [Service]
    ExecStart=
    ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2376```
 * To access the remote docker API `docker -H ${ip_address} [command] `



