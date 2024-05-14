import paramiko
import os

# Загрузка переменных окружения
RM_HOST = os.getenv('RM_HOST')
RM_PORT = int(os.getenv('RM_PORT', 22))  # Использование порта по умолчанию 22, если RM_PORT не задан
RM_USER = os.getenv('RM_USER')
RM_PASSWORD = os.getenv('RM_PASSWORD')

def get_latest_replication_logs():
    ssh_host = RM_HOST
    ssh_user = RM_USER
    ssh_password = RM_PASSWORD
    ssh_port = RM_PORT
    
    try:
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh.connect(ssh_host, port=ssh_port, username=ssh_user, password=ssh_password)
        ssh.exec_command("/tmp/view-log.sh > log.txt")
        stdin, stdout, stderr = ssh.exec_command("cat log.txt | tail -n 20")

        logs = stdout.read().decode()
        error_logs = stderr.read().decode()
        
        if error_logs:
            logs += f"\nОшибки при выполнении команды:\n{error_logs}"

        ssh.close()
        return logs
    except Exception as e:
        return f"Ошибка при доступе к удаленному серверу: {str(e)}"
