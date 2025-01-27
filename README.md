# README

## DESCRIPTION
Tiny Insurer App is a learning process in messaging (with RabbitMQ), GraphQL and websockets topics.

The app simulates an Insurer Company that receive Insured and Vehicle informations and emmit an insured policy to the client.

This is a three part app that needs to run side-by-side.
- [Tiny Insurer Web](https://github.com/thiagoalencar1/tiny-insurer-web/)
- Tiny Insurer GraphQL (this)
- [Tiny Insurer App - Rest API](https://github.com/thiagoalencar1/tiny-insurer-rest).

## STACK
- Docker
- Ruby 3.3.0
- Rails 7.1.3.2
- Rspec
- Bunny
- pry-byebug
- RabbitMQ
- GraphQL

## REQUIREMENTS
- Docker

## RUN
1. To see this application in action, up both parts with one simple `docker-compose up`.
2. Access the `localhost:3000/graphiql` or use your favorite API platform like Postman and Insomnia.
3. Go to the Endpoints and Payloads

### ENDPOINTS AND PAYLOAD
Get policy by ID
```graphql
{
  policy(id: 1) {
    id
    insuredAt
    insuredUntil
    insured {
      id
      name
      cpf
    }
    vehicle {
      id
      plate
      brand
      model
      year
    }
  }
}
```

Get all Policies
```graphql
{
  policies {
    id
    insuredAt
    insuredUntil
    insured {
      id
      name
      cpf
    }
    vehicle {
      id
      plate
      brand
      model
      year
    }
  }
}
```

Create new policy
```graphql
mutation createPolicyMutation(
  $insuredAt: String!
  $insuredUntil: String!
  $insuredName: String!
  $insuredCpf: String!
  $vehiclePlate: String!
  $vehicleBrand: String!
  $vehicleModel: String!
  $vehicleYear: Int!
) {
  createPolicy(
    input: {
      policy: {
        insuredAt: $insuredAt
        insuredUntil: $insuredUntil
        insured: { name: $insuredName, cpf: $insuredCpf }
        vehicle: {
          plate: $vehiclePlate
          brand: $vehicleBrand
          model: $vehicleModel
          year: $vehicleYear
        }
      }
    }
  ){ success }
}
```

## TESTS
