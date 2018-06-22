## Installation
  This project makes use of [bundler](http://bundler.io/), to install run
  
  ```$ gem install bundler```
    
  After installing bundler, bundle install will download all dependencies
  
  ```$ bundle install```
    
  Other useful commands are as follows
  
  ```$ bundle exec rspec```
    
  ```$ bundle exec rubocop```

## API design
  
  Calling a resource will return a summary representation, for example

  ` GET /v1/users `

  will return a representation of users available through the api.

  Fetching individual resources will provide a representation of that object

  `GET /v1/users/1`

  Resources made available through this api are as follows.

  ```GET /v1/users ```

  ```POST /v1/users ```

  ```GET /v1/users/:id ```

  ```PUT /v1/users/:id ```

  ```DELETE /v1/users/:id ```

  * Users/:id/MedicalRecommendations

  ```GET /v1/user/:id/medical_recommendations ```

  ```POST /v1/user/:id/medical_recommendations ```

  ```GET /v1/user/:id/medical_recommendations/:id ```

  ```PUT /v1/user/:id/medical_recommendations/:id ```

  ```DELETE /v1/user/:id/medical_recommendations/:id ```

  * Users/:id/StateIdentifiers

  ```GET /v1/user/:id/staate_identifiers ```

  ```POST /v1/user/:id/staate_identifiers ```

  ```GET /v1/user/:id/staate_identifiers/:id ```

  ```PUT /v1/user/:id/staate_identifiers/:id ```

  ```DELETE /v1/user/:id/staate_identifiers/:id ```

  [deployed on heroku](https://dry-river-18490.herokuapp.com/v1/users)

  [image store via ActiveStorage](http://guides.rubyonrails.org/active_storage_overview.html)
