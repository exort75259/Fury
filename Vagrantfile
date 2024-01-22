Vagrant.configure("2") do |config|
  config.vm.define "vm1" do |mysql_prometheus|
    mysql_prometheus.vm.box = "bento/ubuntu-22.04"
    mysql_prometheus.vm.network "public_network"
    mysql_prometheus.vm.provision "shell", inline: <<-SHELL
      # Установка MySQL
      sudo apt-get update
      sudo apt-get install -y mysql-server

      # Запуск MySQL
      sudo service mysql start

      #учетку создаю для mysql exporter
      sudo groupadd --system mysqld_exporter
      sudo useradd -s /bin/false -r -g mysqld_exporter mysqld_exporter

      # учетка бд для mysqld_exporter

      sudo -u root -p
      CREATE USER 'exort'@'localhost' IDENTIFIED BY '111' WITH MAX_USER_CONNECTIONS 3;
      GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'exort'@'localhost';
      quit;
    
      # Установка MySQL Exporter
      wget https://github.com/prometheus/mysqld_exporter/releases/download/v0.12.1/mysqld_exporter-0.12.1.linux-amd64.tar.gz
      tar xvf mysqld_exporter-0.12.1.linux-amd64.tar.gz
      sudo mv mysqld_exporter-0.12.1.linux-amd64/mysqld_exporter /usr/local/bin/
      sudo chmod +x /usr/local/bin/mysqld_exporter

      # Create cnf file for mysql_exporter with acc and pass
      sudo tee /etc/.my.cnf > /dev/null <<EOF
      [client]
      user=exort
      password=111
EOF
      sudo chown root:mysqld_exporter /etc/.my.cnf

      # Создание службы systemd для mysqld_exporter
      sudo tee /etc/systemd/system/mysqld_exporter.service > /dev/null <<EOF
[Unit]
Description=Prometheus MySQL Exporter
Wants=network.target
After=network.target
      
      
[Service]
User=mysqld_exporter
Group=mysqld_exporter
Type=simple
Restart=always
ExecStart=/usr/local/bin/mysqld_exporter --config.my-cnf /etc/.my.cnf
      
[Install]
WantedBy=multi-user.target
EOF
      
    
      # Перезагрузка systemd
      sudo systemctl restart mysql.service
      sudo systemctl daemon-reload
    
      # Запуск mysqld_exporter и настройка автозапуска
      sudo systemctl daemon-reload
      sudo systemctl start mysqld_exporter
      sudo systemctl enable mysqld_exporter
      
      # Установка node_exporter
      wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz
      tar xvfz node_exporter-*.tar.gz
      sudo mv node_exporter-1.5.0.linux-amd64/node_exporter /usr/local/bin
      rm -r node_exporter-1.5.0.linux-amd64*
      sudo tee /etc/systemd/system/node_exporter.service > /dev/null <<EOF
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
Restart=on-failure
RestartSec=5s
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF
      sudo useradd -rs /bin/false node_exporter
      # Перезагрузка systemd
      sudo systemctl daemon-reload

      # Запуск node_exporter и настройка автозапуска
      sudo systemctl start node_exporter
      sudo systemctl enable node_exporter
      
   
    
       SHELL
  end

  config.vm.define "vm2" do |prometheus|
      prometheus.vm.box = "bento/ubuntu-22.04"
      prometheus.vm.network "public_network"
      prometheus.vm.provision "shell", inline: <<-SHELL
      
      
      #install prometheus

      wget https://github.com/prometheus/prometheus/releases/download/v2.37.6/prometheus-2.37.6.linux-amd64.tar.gz
      tar xvfz prometheus-*.tar.gz
      rm prometheus-*.tar.gz
      sudo mkdir /etc/prometheus /var/lib/prometheus
      cd prometheus-2.37.6.linux-amd64
      sudo mv prometheus promtool /usr/local/bin/
      sudo mv prometheus.yml /etc/prometheus/prometheus.yml
      sudo mv consoles/ console_libraries/ /etc/prometheus/
      prometheus --version

      # adding user and owner
      sudo useradd -rs /bin/false prometheus
      sudo chown -R prometheus: /etc/prometheus /var/lib/prometheus

      # create service for systemd

      sudo tee /etc/systemd/system/prometheus.service > /dev/null <<EOF
[Service]
User=prometheus
Group=prometheus
Type=simple
Restart=on-failure
RestartSec=5s
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries \
    --web.listen-address=0.0.0.0:9090 \
    --web.enable-lifecycle \
    --log.level=info

[Install]
WantedBy=multi-user.target
EOF 
      # reload prometheus 
      sudo systemctl daemon-reload
      sudo systemctl start prometheus
      sudo systemctl status prometheus

      #Install and Deploy the Grafana Server


      sudo apt-get install -y apt-transport-https software-properties-common

      sudo wget -q -O /usr/share/keyrings/grafana.key https://apt.grafana.com/gpg.key
      echo "deb [signed-by=/usr/share/keyrings/grafana.key] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

      sudo apt-get update
      sudo apt-get install grafana

      sudo systemctl daemon-reload
      sudo systemctl enable grafana-server.service
      sudo systemctl start grafana-server
      sudo systemctl status grafana-server

      #alertmanager installation

      wget https://github.com/prometheus/alertmanager/releases/download/v0.26.0/alertmanager-0.26.0.linux-amd64.tar.gz
      tar xvzf alertmanager-0.26.0.linux-amd64.tar.gz
      sudo mv alertmanager-0.26.0.linux-amd64/alertmanager /usr/local/bin/
      sudo mkdir /etc/alertmanager/
      sudo mv alertmanager-0.26.0.linux-amd64/amtool /etc/alertmanager

      # alermanager cnf

      sudo tee /etc/alertmanager/alertmanager.yml > /dev/null <<EOF
global:
  resolve_timeout: 1m
    
route:
  group_by: ['alertname']
  group_wait: 10s
  group_interval: 10s
  repeat_interval: 30s
  receiver: 'gmail-notifications'
    
receivers:
- name: 'gmail-notifications'
  email_configs:
  - to: 'xxxxxx@gmail.com'
    from: 'xxxxxx@gmail.com'
    smarthost: smtp.gmail.com:587
    auth_username: 'xxxxxx@gmail.com'
    auth_identity: 'xxxxxx@gmail.com'
    auth_password: 'password'
    send_resolved: true
    
inhibit_rules:
  - source_match:
      severity: 'critical'
    target_match:
      severity: 'warning'
    equal: ['alertname', 'dev', 'instance' ]  
EOF

      # alertmanager unit file systemd

      sudo tee /etc/systemd/system/alertmanager.service > /dev/null <<EOF
[Unit]
Description=AlertManager Server Service
Wants=network-online.target
After=network-online.target

[Service]
User=root
Group=root
Type=simple
ExecStart=/usr/local/bin/alertmanager --config.file /etc/alertmanager/alertmanager.yml --web.external-url=http://192.168.0.106:9093

[Install]
WantedBy=multi-user.target
EOF
      SHELL
  end
end