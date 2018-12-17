#!/bin/bash

echo "SubCA y generando un CSR"
echo "------------------------"
echo "1) Generando una clave rsa de 2048"
openssl genrsa -out example.org.key 2048

echo "2) Inspeccionando la clave privada"
openssl rsa -in example.org.key -noout -text

echo "3) Generando la clave publica e inspeccionandola"
openssl rsa -in example.org.key -pubout -out example.org.pubkey
openssl rsa -in example.org.pubkey -pubin -noout -text

echo "4) Generando el CSR (Certificate signing request) e inspeccionandolo"
openssl req -new -sha256 -key example.org.key -out example.org.csr
openssl req -in example.org.csr -noout -text
