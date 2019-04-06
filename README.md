# Grupo 28

[Aplicación](https://salty-citadel-84152.herokuapp.com/)

## Changing the Gemfile or the Dockerfile

```bash
docker-compose run web bundle install
docker-compose up --build
```

## Running the server (locally)

```bash
docker-compose up
```

## Stopping the server (locally)

```bash
docker-compose down
```

## Building the container image (Heroku Container Registry)

```bash
heroku container:push web
```

## Releasing the container image (Heroku Container Registry)

```bash
heroku container:release web
```
