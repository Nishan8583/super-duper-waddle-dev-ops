#!/bin/bash
echo "[+] Install openssl if not present"
sudo apt install openssl -y

echo "[+] Creating essential directory"
sudo mkdir -p /usr/share/opensearch/configs/certs
sudo mkdir -p /usr/share/opensearch/data/

echo "[+] Generating a private key"
sudo openssl genrsa -out /usr/share/opensearch/configs/certs/root-ca-key.pem 2048

echo "[+] Generating root certificate"
sudo openssl req -new -x509 -sha256 -key /usr/share/opensearch/configs/certs/root-ca-key.pem -out /usr/share/opensearch/configs/certs/root-ca.pem -days 730

echo "[+] Creating directories for logsatsh"
sudo mkdir -p /usr/share/opensearch/configs/logstash/pipeline


sudo cp -R ./configs/* /usr/share/opensearch/configs/
sudo chmod -R 777 /usr/share/opensearch/*

