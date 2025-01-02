#bin/sh
terraform output -json > terraform-output.json
JMETER_SERVER_1_PUBLIC_IP=$(jq -r '.jmeter_server_1_public_ip.value' terraform-output.json)
JMETER_SERVER_2_PUBLIC_IP=$(jq -r '.jmeter_server_2_public_ip.value' terraform-output.json)
JMETER_SERVER_1_PRIVATE_IP=$(jq -r '.jmeter_server_1_private_ip.value' terraform-output.json)
JMETER_SERVER_2_PRIVATE_IP=$(jq -r '.jmeter_server_2_private_ip.value' terraform-output.json)
JMETER_CLIENT_PUBLIC_IP=$(jq -r '.jmeter_client_public_ip.value' terraform-output.json)
JMETER_CLIENT_PRIVATE_IP=$(jq -r '.jmeter_client_private_ip.value' terraform-output.json)
$(jq -r '.private_key.value' terraform-output.json) >> perf-test.pem
ssh -i perf-test.pem -o StrictHostKeyChecking=no adminuser@$JMETER_CLIENT_PUBLIC_IP 'mkdir -p /home/adminuser/apk-perf-test && cd /home/adminuser/apk-perf-test && git clone --no-checkout https://github.com/wso2/apk.git && cd apk && git sparse-checkout init && git sparse-checkout set test/performance git checkout'
ssh -i perf-test.pem -o StrictHostKeyChecking=no adminuser@$JMETER_SERVER_1_PUBLIC_IP 'mkdir -p /home/adminuser/apk-perf-test && cd /home/adminuser/apk-perf-test && git clone --no-checkout https://github.com/wso2/apk.git && cd apk && git sparse-checkout init && git sparse-checkout set test/performance git checkout'
ssh -i perf-test.pem -o StrictHostKeyChecking=no adminuser@$JMETER_SERVER_2_PUBLIC_IP 'mkdir -p /home/adminuser/apk-perf-test && cd /home/adminuser/apk-perf-test && git clone --no-checkout https://github.com/wso2/apk.git && cd apk && git sparse-checkout init && git sparse-checkout set test/performance git checkout'

#   provisioner "remote-exec" {
#     connection {
#       type        = "ssh"
#       user        = "adminuser"
#       private_key = data.azurerm_key_vault_secret.apk-perf-test-key.value
#       host        = self.public_ip_address
#     }
#     inline = [
#       "sudo apt-get update -y && sudo apt-get install -y unzip",
#       "wget https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.24%2B8/OpenJDK11U-jdk_x64_linux_hotspot_11.0.24_8.tar.gz",
#       "tar -xvf OpenJDK11U-jdk_x64_linux_hotspot_11.0.24_8.tar.gz",
#       "sudo mv jdk-11.0.24+8 /opt/jdk",
#       "echo 'export JAVA_HOME=/opt/jdk' >> ~/.bashrc",
#       "source ~/.bashrc",
#       "wget https://dlcdn.apache.org//jmeter/binaries/apache-jmeter-5.6.3.tgz",
#       "tar -xvf apache-jmeter-5.6.3.tgz",
#       "sudo mv apache-jmeter-5.6.3 /opt/jmeter"
#     ]
#   }