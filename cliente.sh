#!/bin/bash

echo "Introduce el nombre del usuario a generar el certificado"
read usuario


echo "SubCA y generando un CSR"
echo "------------------------"
echo "1) Generando una clave rsa de 2048"
openssl genrsa -out $usuario.key 2048

echo "2) Inspeccionando la clave privada"
openssl rsa -in $usuario.key -noout -text

echo "3) Generando la clave publica e inspeccionandola"
openssl rsa -in $usuario.key -pubout -out $usuario.pubkey
openssl rsa -in $usuario.pubkey -pubin -noout -text

echo "4) Generando el CSR (Certificate signing request) e inspeccionandolo"
openssl req -new -sha256 -key $usuario.key -out $usuario.csr
openssl req -in $usuario.csr -noout -text


echo "3) Firmando el csr del usuario"
echo '10' > ca.srl
openssl x509 -req -sha384 -in $usuario.csr -CA example.org.crt -CAkey example.org.key -CAcreateserial -out $usuario.crt -days 500

echo "4) Verificando"
openssl x509 -in $usuario.crt -noout -text

echo "Generando p12 "
openssl pkcs12 -export -out $usuario.p12 -inkey $usuario.key -in $usuario.crt -certfile example.org.crt
