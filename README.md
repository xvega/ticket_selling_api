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

#Whats the normal flow?

Think of this API as an app that 2 types of user would potentially use:

- Admin
- User

An admin, would make use of the `events` and `tickets` endpoints

A user, would create a `reservation` and then a `payment` for such reservation


My assumptions for the `frontend` are the following:   
- The frontend will expect JSON responses
- For payments, you'll find I have a `token` in that table, and that you will need it to pay for a reservation, that's intended.
I believe in the frontend a preflight payment will take place and that token could be sent from there.
- A user wouldn't be aware 100% of a reservation, if they are just buying tickets.

My assumptions for the `backend` are the following:

- Any kind of authentication is expected, in my case, I'm using a `Bearer token`
- Pagination, sort and limit, are extra params that can be added to GET requests, in order to provide users
a fast API.
- I decided to create a `ticket` that holds a value `name` which works as a type, for instance, `VIP`, `normal`, anything.
and at the same time, a ticket can hold information such as `quantity` and `price`. I thought there is no need to create 
records that match the amount of tickets that we create per event.
- With the abovementioned assumption, I decided to `reserve` tickets in order to later `pay` for them, that will allow 
users to have a valid reservation for some minutes just as cinema web apps do when you have a preflight screen to buy tickets.
- I tried to remove dependencies as much as possible, one example of this is creating a `purchasable` module in which you could
potentially create another kind of ticket and then you would just need to change the interface objects are responding to now.


If I had more time, what would I add/change?

- I would add a cronjob that runs a script every X minutes, in order to set expired reservations as available tickets.
- I would add more test coverage, specially to the integration tests and I would try to test more edge cases
- I would refactor some parts of the app I don't like. In order to follow more the SOLID principles.
- I would deploy the API to AWS, using EC2 and RDS, among other services.