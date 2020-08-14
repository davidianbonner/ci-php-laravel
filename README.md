# Docker image for Laravel in CI environments

**Previously (https://hub.docker.com/r/davidianbonner/wercker-php-laravel)[davidianbonner/wercker-php-laravel]**

This image installs the following software:

* PHP
* Composer
* Chrome (for dusk)
* Laravel Envoy
* [Sentry Command Line Interface](https://github.com/getsentry/sentry-cli)
* NPM

### Build

```
docker build -t davidianbonner/ci-php-laravel:latest -t davidianbonner/ci-php-laravel:[PHP VERSION] .
```

### Send to Docker Hub

```
docker push davidianbonner/ci-php-laravel
```
