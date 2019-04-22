# Grupo 28

[https://salty-citadel-84152.herokuapp.com/](https://salty-citadel-84152.herokuapp.com/)

## Running Rubocop

```bash
docker-compose run web rubocop
```

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

## Getting admin permision

```bash
sudo chown -R $USER:$USER .
```
