#### Ansible playbook to install, upgrade, and uninstall Halo agent onto debian and rpm based OSes.

#### Install instructions on MAC OS X

1. Install Ansible `brew install ansible` (If you don't have brew preinstalled, then follow https://valdhaus.co/writings/ansible-mac-osx/ to install ansible)

#### Playbook configurations

1. Inside the halo directory, there are 3 things you need to configure:
    - list of server's ip addresses
    - their corresponding login usernames
    - Halo agent key

2. To add the list of connecting ip addresses, open the file named `hosts`

    Put the corresponding OSes ip addresses under the same groups. `NOTE: The ips in the same group MUST have the same login username`
    
    Sample file content
    
    ```
        [ubuntu]
        12.34.567.890

        [rpm]
        21.43.765.089
    ```
    
3. Now that we have the list of ip addresses stored in the inventory file `hosts`, we need to add the list of login usernames.
    Open the file named `halo.yml`

    Sample file content

    ```
        - name: Configure Halo on Ubuntu based oses
          hosts: ubuntu
          remote_user: ubuntu
          roles:
            - install
            - uninstall
            - upgrade
        
        - name: Configure Halo on RPM based oses
          hosts: rpm
          remote_user: ec2-user
          roles:
            - install
            - uninstall
            - upgrade
    ```
    
    Edit the remote_user to be your server's login username. Here I have the `ubuntu` user for Ubuntu OSes and `ec2-user` for redhat/centos OSes.

4. Open the file `all` located in `group_vars/all` and paste in your Halo agent key.

    Sample File content
    
    ```
        agent_key: abcabcabcabc12345
    ```

#### Program Usage (Commands) install, upgrade, uninstall, start, stop, restart

1. Run the following command to install Halo.
    `ansible-playbook -i hosts -u halo.yml --private-key=<ssh_key_path> --sudo -t install`

2. Run the following command to upgrade Halo.
    `ansible-playbook -i hosts -u halo.yml --private-key=<ssh_key_path> --sudo -t upgrade`

3. Run the following command to uninstall Halo.
    `ansible-playbook -i hosts -u halo.yml --private-key=<ssh_key_path> --sudo -t uninstall`

4. Run the following command to start Halo.
    `ansible-playbook -i hosts -u halo.yml --private-key=<ssh_key_path> --sudo -t start`

5. Run the following command to stop Halo.
    `ansible-playbook -i hosts -u halo.yml --private-key=<ssh_key_path> --sudo -t stop`

6. Run the following command to restart Halo.
    `ansible-playbook -i hosts -u halo.yml --private-key=<ssh_key_path> --sudo -t restart`