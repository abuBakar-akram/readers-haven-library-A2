
# Readers' Haven Public Library

A responsive static website for Readers' Haven Public Library.

## Technologies

- HTML5
- CSS3
- Node.js
- Parcel
- Docker
- Nginx

## Development

Install dependencies:

npm ci

Build the website:

npm run build

## Docker

Build the Docker image:

docker image build -t readers-haven:v1 .

Run the website:

docker container run -d --name readers-haven -p 8080:80 readers-haven:v1
