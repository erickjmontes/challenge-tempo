# Challenge Tempo

## Kubernetes

● Ejecute un servicio web que responde a solicitudes HTTP (siéntase libre de usar
cualquier imagen Docker existente o cree la suya propia)


- Creacion de Namespace y Deployment de la web server.

kubectl create namespace challenge-tempo
kubectl -n challenge-tempo create deployment web-tempo --image=nginx --port=80

● Configure su aplicación para servir en 443 apuntando a 80 (Deseable)

- Creacion del Service que expone el acceso al web server.

kubectl -n challenge-tempo expose deployment web-tempo --port=443 --target-port=80

● Use un certificado autofirmado para habilitar SSL (Deseable)

- Creacion del cert autofirmado, se añade al Secret y este se asocia a un ingress que es el que va a exponer la url de acceso al web service (app).

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ${web-tempo.key} -out ${web-tempo.crt} -subj "/CN=${challenge-tempo.com}/O=${challenge-tempo.com}" -addext "subjectAltName = DNS:${challenge-tempo.com}"

kubectl -n challenge-tempo create secret tls tempo-cert --key tempo.key --cert tempo.crt

kubectl -n challenge-tempo create ingress web-tempo --rule="challenge-tempo.com/=web-tempo:443,tls=tempo-cert"

●  Configure el escalado automático de su aplicación usando la CPU como
indicador con mínimo 2 y máximo 10 réplicas

- Se genera un HPA con la config solicitada. 
kubectl -n challenge-tempo autoscale deployment web-tempo --cpu-percent=70 --min=2--max=10

## Terraform

● Un recurso de almacenamiento genérico (Azure Storage Account, S3, GCS, etc.)

