# Tea Time Subscribe API

The Tea Time Subscribe API is a Ruby on Rails application that provides subscription management and tea-related information through a set of API endpoints. This API allows users to subscribe to various services and retrieve information about different teas.

## Table of Contents
1. [Installation](#installation)
2. [API Endpoints](#api-endpoints)
  - [List Subscriptions](#list-subscriptions)
  - [Subscribe](#subscribe)
  - [Cancel Subscription](#cancel-subscription)
  - [List Teas](#list-teas)
3. [Contributors](#contributors)

## Installation

To run the Tea Time Subscribe API locally, follow these steps:

Clone the repository to your local machine:

`git clone <repo-url>`

`cd tea_time_subscribe`

Install the required dependencies:

`bundle install`

Set up the database and run migrations:

`rails db:create`
`rails db:migrate`

Start the Rails server:

`rails server`

The API will be accessible at http://localhost:3000.

## API Endpoints

### List Subscriptions

- Endpoint: `GET /api/v0/:id/subscriptions`
- Description: Retrieve a list of subscriptions for a specific user.
- Parameters:
  - `:id` (URL parameter): The user's ID.

Example Request:

`GET /api/v0/1/subscriptions`

Response:
```
{
    "data": [
        {
            "id": "1",
            "type": "subscription",
            "attributes": {
                "customer_id": 1,
                "title": "Rustic Wool Bench",
                "price": 60.15,
                "status": "cancelled",
                "frequency": "enim"
            }
        },
        {
            "id": "2",
            "type": "subscription",
            "attributes": {
                "customer_id": 1,
                "title": "Heavy Duty Marble Computer",
                "price": 30.22,
                "status": "cancelled",
                "frequency": "facere"
            }
        }
    ]
}
```
### Subscribe

- Endpoint: `POST /api/v0/subscribe`
- Description: Create a new subscription for a user.
- Example Request: (in the body of the request)
```
{
  "subscription": {
    "title": "black tea",
    "price": 10.99,
    "status": "active",
    "frequency": "2x per month",
    "customer_id": 1  
  }
}
```
- Response:
```
{
    "data": {
        "id": "21",
        "type": "subscription",
        "attributes": {
            "customer_id": 1,
            "title": "black tea",
            "price": 10.99,
            "status": "active",
            "frequency": "2x per month"
        }
    }
}
```

### Cancel Subscription
- Endpoint: `PATCH /api/v0/cancel/:id`
- Description: Cancel a specific subscription.
- Example Request:

`PATCH /api/v0/cancel/21`

- Response:
```
{
    "data": {
        "id": "21",
        "type": "subscription",
        "attributes": {
            "customer_id": 1,
            "title": "black tea",
            "price": 10.99,
            "status": "cancelled",
            "frequency": "2x per month"
        }
    }
}
```

### List Teas
- Endpoint: `GET /api/v0/teas`
- Description: Retrieve information about different teas.
- Parameters:
  - query (URL query parameter, optional): A search query to filter teas.
- Example Request:

`GET /api/v0/teas?query=tea` (can specify type of tea and other items)   

- Response:
```
{
    "data": [
        {
            "id": "645530",
            "type": "tea",
            "attributes": {
                "title": "Green Tea Fruit Medley Smoothie",
                "description": "Green Tea Fruit Medley Smoothie is a <b>gluten free, lacto ovo vegetarian, and primal</b> recipe with 4 servings. One portion of this dish contains around <b>2g of protein</b>, <b>1g of fat</b>, and a total of <b>45 calories</b>. For <b>64 cents per serving</b>, this recipe <b>covers 4%</b> of your daily requirements of vitamins and minerals. It is brought to you by Foodista. 62 people found this recipe to be yummy and satisfying. A couple people really liked this breakfast. From preparation to the plate, this recipe takes roughly <b>45 minutes</b>. Head to the store and pick up water, pineapple juice, ice cubes, and a few other things to make it today. With a spoonacular <b>score of 40%</b>, this dish is pretty good. If you like this recipe, take a look at these similar recipes: <a href=\"https://spoonacular.com/recipes/green-tea-fruit-medley-smoothie-1364147\">Green Tea Fruit Medley Smoothie</a>, <a href=\"https://spoonacular.com/recipes/green-tea-fruit-medley-smoothie-1406645\">Green Tea Fruit Medley Smoothie</a>, and <a href=\"https://spoonacular.com/recipes/green-tea-fruit-medley-smoothie-1406283\">Green Tea Fruit Medley Smoothie</a>.",
                "image": "https://spoonacular.com/recipeImages/645530-312x231.jpg",
                "link": "https://spoonacular.com/recipes/green-tea-fruit-medley-smoothie-645530"
              }
            }
          ]     
        }
```

## Future Iterations
- Functionality for adding teas to a customer's subscription is pending.
- Functionality to add user authentication is pending.
- Front-end build is pending.

## Contributors
- [Allen Russell](allenrusselldev@gmail.com) - GitHub: [@garussell](https://github.com/garussell)

