set -e

cd terraform
terraform init
terraform fmt -recursive
terraform apply --auto-approve


cd .. 

cd ansible
chmod 600 .ssh/ssh_private_key 

HOST_IP=$(grep "^concretecms " hosts.ini | awk '{print $2}' | cut -d= -f2)

echo "Waiting for $HOST_IP to be reachable via SSH..."

# Loop until SSH is available
until ssh -o StrictHostKeyChecking=no -i .ssh/ssh_private_key ubuntu@"$HOST_IP" 'echo ok' &>/dev/null; do
    echo "Waiting for $HOST_IP..."
    sleep 3
done

echo "$HOST_IP is reachable. Running Ansible..."

ansible-playbook -i hosts.ini playbook.yaml

cd ..
