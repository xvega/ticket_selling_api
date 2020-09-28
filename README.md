# Ticket Selling API

#Dependencies

- docker

#How to run it?

I've taken care of mostly everything, so you have to run the following commands:

```sh 
docker-compose build
docker-compose up
```

For a couple of endpoints, you need a bearer token. In order to create one, open a new terminal session and run the following commands:

```sh 
docker-compose run app rails console 
ApiKey.create!
```

Then copy the token and add it to your header request

#How to run tests?

```sh 
docker-compose run app rspec spec/
```

#Documentation 

Feel free to use your favorite tool for testing the API, e.g: Postman. If you're in a hurry, I've written API docs using rswag gem

```sh
localhost:3000/api-docs/
```

It's important to note that you should authenticate before making requests in the above link.

For that, it's necessary that you have an ApiKey, in swagger there's a button on the right upper corner `Authorize`,
click the button and add the following `Bearer TOKEN`, replace TOKEN with your own token. Then close the modal and enjoy
testing the API.