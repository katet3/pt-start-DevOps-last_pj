import paramiko

def get_latest_replication_logs():
    ssh_host = 'db_image'  # IP сервера базы данных
    ssh_user = 'root'      # Пользователь для SSH
    ssh_password = '1861'  # Пароль для SSH
    
    try:
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh.connect(ssh_host, username=ssh_user, password=ssh_password)
        ssh.exec_command(f"/tmp/view-log.sh > log.txt")
        stdin, stdout, stderr = ssh.exec_command(f"cat log.txt | tail -n 20")

        logs = stdout.read().decode()
        error_logs = stderr.read().decode()
        
        if error_logs:
            logs += f"\nОшибки при выполнении команды:\n{error_logs}"

        ssh.close()
        return logs
    except Exception as e:
        return f"Ошибка при доступе к удаленному серверу: {str(e)}"
