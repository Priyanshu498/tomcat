#!/bin/bash


TOMCAT_VERSION=$1

if [ -z "$TOMCAT_VERSION" ]; then
  echo "Usage: $0 <TOMCAT_VERSION>"
  echo "Example: $0 9.0.91"
  exit 1
fi

# Determine the OS type
OS=$(cat /etc/os-release | grep '^ID=' | cut -d '=' -f 2 | tr -d '"')

# Function to install Tomcat on Ubuntu
install_tomcat_ubuntu() {
  echo "Installing Tomcat on Ubuntu..."

  # Update and install dependencies
  sudo apt-get update -y
  sudo apt-get install -y default-jdk wget

  # Create Tomcat user and group
  sudo groupadd tomcat || true
  sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat || true

  # Download and install Tomcat
  TOMCAT_MAJOR_VERSION=$(echo $TOMCAT_VERSION | cut -d. -f1)
  wget https://dlcdn.apache.org/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -P /tmp
  sudo mkdir -p /opt/tomcat
  sudo tar xf /tmp/apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /opt/tomcat
  
  # Remove existing symbolic link if it exists
  sudo rm -f /opt/tomcat/latest

  # Create new symbolic link
  sudo ln -s /opt/tomcat/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat/latest
  sudo chown -RH tomcat: /opt/tomcat/apache-tomcat-${TOMCAT_VERSION}
  sudo chown -RH tomcat: /opt/tomcat/latest


 sudo bash -c 'cat <<EOF > /opt/tomcat/latest/conf/tomcat-users.xml
<role rolename="manager-gui" />
<user username="manager" password="19@priyanshu" roles="manager-gui" />
<role rolename="admin-gui" />
<user username="admin" password="19@priyanshu" roles="manager-gui,admin-gui" />
EOF'

#creating a systed service
sudo update-java-alternatives -l


  # Create systemd service file
  sudo bash -c 'cat <<EOF > /etc/systemd/system/tomcat.service
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/default-java
Environment=CATALINA_PID=/opt/tomcat/latest/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat/latest
Environment=CATALINA_BASE=/opt/tomcat/latest
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"
Environment="JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom"

ExecStart=/opt/tomcat/latest/bin/startup.sh
ExecStop=/opt/tomcat/latest/bin/shutdown.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
EOF'

  # Reload systemd daemon and start Tomcat
  sudo systemctl daemon-reload
  sudo systemctl start tomcat
  sudo systemctl enable tomcat
}

# Function to install Tomcat on Red Hat (RHEL/CentOS)
install_tomcat_rhel() {
  echo "Installing Tomcat on Red Hat..."

  # Install dependencies
  sudo yum update -y
  sudo yum install -y java-1.8.0-openjdk wget

  # Create Tomcat user and group
  sudo groupadd tomcat 
  sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat

  # Download and install Tomcat
  TOMCAT_MAJOR_VERSION=$(echo $TOMCAT_VERSION | cut -d. -f1)
  wget https://dlcdn.apache.org/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -P /tmp
  sudo mkdir -p /opt/tomcat
  sudo tar xf /tmp/apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /opt/tomcat
  
  # Remove existing symbolic link if it exists
  sudo rm -f /opt/tomcat/latest

 # Create new symbolic link
  sudo ln -s /opt/tomcat/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat/latest
  sudo chown -RH tomcat: /opt/tomcat/apache-tomcat-${TOMCAT_VERSION}
  sudo chown -RH tomcat: /opt/tomcat/latest

  

 sudo bash -c 'cat <<EOF > /opt/tomcat/latest/conf/tomcat-users.xml
<role rolename="manager-gui" />
<user username="manager" password="19@priyanshu" roles="manager-gui" />
<role rolename="admin-gui" />
<user username="admin" password="19@priyanshu" roles="manager-gui,admin-gui" />
EOF'

  # Create systemd service file
  sudo update-java-alternatives -l

  sudo bash -c 'cat <<EOF > /etc/systemd/system/tomcat.service
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/default-java
Environment=CATALINA_PID=/opt/tomcat/latest/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat/latest
Environment=CATALINA_BASE=/opt/tomcat/latest
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"
Environment="JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom"

ExecStart=/opt/tomcat/latest/bin/startup.sh
ExecStop=/opt/tomcat/latest/bin/shutdown.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
EOF'



  # Reload systemd daemon and start Tomcat
  sudo systemctl daemon-reload
  sudo systemctl start tomcat
  sudo systemctl enable tomcat
}

# Install Tomcat based on OS type
case "$OS" in
  ubuntu)
    install_tomcat_ubuntu
    ;;
  rhel|centos)
    install_tomcat_rhel
    ;;
  *)
    echo "Unsupported OS: $OS"
    exit 1
    ;;
esac

echo "Tomcat installation completed."

