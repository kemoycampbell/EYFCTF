#cloud-config
package_update: true
package_upgrade: true

write_files:
  - path: /home/ec2-user/setup.sh
    permissions: '0755'
    owner: ec2-user:ec2-user
    content: |
      #!/bin/bash
      set -e

      # Fix ownership & permissions on home directory to avoid permission issues
      sudo chown -R ec2-user:ec2-user /home/ec2-user
      sudo chmod 755 /home/ec2-user

      # Install core packages
      sudo dnf install -y --allowerasing python3 python3-pip git curl

      # Install Docker from Amazon Linux 2023 official repo
      sudo dnf install -y --allowerasing docker
      sudo systemctl enable docker
      sudo systemctl start docker
      sudo usermod -aG docker ec2-user

      # Install Docker Compose v2
      sudo curl -SL https://github.com/docker/compose/releases/download/v2.38.2/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
      sudo chmod +x /usr/local/bin/docker-compose
      sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

      # Run all user-specific commands as ec2-user in one block to avoid permission issues
      sudo -u ec2-user bash -c '
        cd ~
        git clone https://github.com/kemoycampbell/EYFCTF
        cd EYFCTF
        git checkout main


        python3 -m venv eyfctf_venv
        source eyfctf_venv/bin/activate
        pip install -r requirements.txt

        python3 cd && provision.py ${ctfd_yaml_base64}
        python3 cd ../ && ctfd.py
        source eyfctf_venv/bin/deactivate

        docker-compose up -d
      '

runcmd:
  - su - ec2-user -c "/home/ec2-user/setup.sh"
