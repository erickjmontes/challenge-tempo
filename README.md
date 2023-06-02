# Challenge Tenpo

## Kubernetes

● Ejecute un servicio web que responde a solicitudes HTTP (siéntase libre de usar
cualquier imagen Docker existente o cree la suya propia

kubectl create namespace challenge-tenpo
kubectl -n challenge-tenpo create deployment web-tenpo --image=nginx --port=80

● Configure su aplicación para servir en 443 apuntando a 80 (Deseable)

kubectl -n challenge-tenpo expose deployment web-tenpo --port=443 --target-port=80

● Use un certificado autofirmado para habilitar SSL (Deseable)

- Creacion del cert autofirmado, se añade al Secret y este se asocia a un ingress que es el que va a exponer la url de acceso al web service (app).

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ${web-tenpo.key} -out ${web-tenpo.crt} -subj "/CN=${challenge-tenpo.com}/O=${challenge-tenpo.com}" -addext "subjectAltName = DNS:${challenge-tenpo.com}"

kubectl -n challenge-tenpo create secret tls tenpo-cert --key tenpo.key --cert tenpo.crt

kubectl -n challenge-tenpo create ingress web-tenpo --rule="challenge-tenpo.com/=web-tenpo:443,tls=tenpo-cert"

●  Configure el escalado automático de su aplicación usando la CPU como
indicador con mínimo 2 y máximo 10 réplicas

kubectl -n challenge-tenpo autoscale deployment web-tenpo --cpu-percent=70 --min=2--max=10

## Terraform

● Un recurso de almacenamiento genérico (Azure Storage Account, S3, GCS, etc.)


