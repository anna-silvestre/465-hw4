SETUP:

sudo apt update
sudo apt remove -y docker.io docker-compose docker-compose-v2 \
containerd runc 2>/dev/null || true
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
sudo tee /etc/apt/sources.list.d/docker.sources >/dev/null <<EOF_DOCKER
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF_DOCKER
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io \
docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker "$USER"

sudo apt install -y nmap tcpdump tshark netcat-openbsd
sudo add-apt-repository -y ppa:oisf/suricata-stable
sudo apt update
sudo apt install -y suricata
sudo usermod -aG suricata "$USER"

logout


TASK 1:

printf 'CSCE465-FAKE-TOKEN-%s' "$(openssl rand -hex 8)" > fake_secrets.txt;

sudo docker compose up -d --build
sudo docker compose ps

TASK 3:

fetch benign webpage: sudo docker compose exec agent-node curl http://172.30.0.40:8000/benign.html
exfiltrate: sudo docker compose exec agent-node ./mock_skill.sh exfiltrate-course-file
unapproved container port: sudo docker compose exec agent-node curl --max-time 5 http://172.30.0.40:8080/
existing response traffic: nc -v 172.30.0.10 9009
unrelated: sudo docker compose exec web-lab curl -X POST http://172.30.0.66:8080/ 

TASK 4:
mkdir -p suricata-malicious suricata-clean
sudo suricata -k none -r hw4-malicious.pcap -S local.rules -l suricata-malicious
sudo suricata -k none -r hw4-clean.pcap -S local.rules -l suricata-clean

sudo cat suricata-malicious/fast.log
sudo cat suricata-clean/fast.log