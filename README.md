# Challenge Tempo

● Ejecute un servicio web que responde a solicitudes HTTP (siéntase libre de usar
cualquier imagen Docker existente o cree la suya propia)

kubectl create namespace challenge-tempo
kubectl -n challenge-tempo create deployment web-tempo --image=nginx --port=80

● Configure su aplicación para servir en 443 apuntando a 80 (Deseable)

kubectl -n challenge-tempo expose deployment web-tempo --port=443 --target-port=80

● Use un certificado autofirmado para habilitar SSL (Deseable)

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ${web-tempo.key} -out ${web-tempo.crt} -subj "/CN=${challenge-tempo.com}/O=${challenge-tempo.com}" -addext "subjectAltName = DNS:${challenge-tempo.com}"

kubectl -n challenge-tempo create secret tls tempo-cert --key tempo.key --cert tempo.crt

kubectl -n challenge-tempo create ingress web-tempo --rule="challenge-tempo.com/=web-tempo:443,tls=tempo-cert"

●  Configure el escalado automático de su aplicación usando la CPU como
indicador con mínimo 2 y máximo 10 réplicas

kubectl -n challenge-tempo autoscale deployment web-tempo --cpu-percent=70 --min=2--max=10