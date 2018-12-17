#!/bin/bash

echo "CA Key y Certificado auto firmado"
echo "---------------------------------"

echo "1) Generando la clave privada"
openssl genrsa -out ca.key 2048

echo "2) Certificado auto firmado"
openssl req -new -x509 -key ca.key -out ca.crt

echo "3) Firmando el csr"
echo 'ED4B4A80662B1B4C' > ca.srl
openssl x509 -req -sha384 -in example.org.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out example.org.crt -days 500

echo "4) Verificando"
openssl x509 -in example.org.crt -noout -text
