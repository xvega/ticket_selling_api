# Ticket Selling API

##Dependencies

- docker

##How to run it?

I've taken care of everything, so you have to run the following commands:

```sh 
docker-compose build
docker-compose up
```

##How to run tests?

```sh 
docker-compose run app rspec spec/
```

##Documentation 

Feel free to use your favorite tool for testing the API, e.g: Postman. If you're in a hurry, I've written API docs using rswag gem

```sh
localhost:3000/api-docs/
```

