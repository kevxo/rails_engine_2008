
# Rails Engine
## Project Description
  You are working for a company developing an E-Commerce Application. Your team is working in a service-oriented architecture, meaning the front and back ends of this application are separate and communicate via APIs. Your job is to expose the data that powers the site through an API that the front end will consume.

### Learning Goals
## Explicit
## Below are technical goals that have be applied in this project.
  * The priority of these goals are demonstrated using a star grading system.
  * By the end of this project:
  * Student should have a functional understanding of the concept ⭐ ⭐ ⭐
  * Student should have a familiar understanding, but may still have questions ⭐ ⭐
  * Student should know of the concept, but need further resources to implement ⭐

  * Expose an API ⭐ ⭐ ⭐
  * Use serializers to format JSON responses ⭐ ⭐ ⭐
  * Test API exposure ⭐ ⭐ ⭐
  * Compose advanced ActiveRecord queries to analyze information stored in SQL databases ⭐ ⭐
  * Write basic SQL statements without the assistance of an ORM ⭐

## Installment
  rbenv install 2.5.3
  Rails version 5.2.4.3 
  bundle install
  rails db:{drop,create,migrate,seed}
  
## Endpoints

  - GET /api/v1/merchants or GET /api/v1/items
   - GET /api/v1/merchants/:id or GET /api/v1/items/:id
    - POST /api/v1/merchants or POST /api/v1/items
     - PACTH /api/v1/merchants/:id or PATCH /api/v1/items/:id
     
  Relationships
   - GET /api/v1/merchants/:id/items - return all items associated with a merchant.
   - GET /api/v1/items/:id/merchants - return the merchant associated with an item
   
   Finders 
   - GET /api/v1/resource/find?attribute=value
   - GET /api/v1/resource/find_all?attribute=value
   Business Intelligence
   - GET /api/v1/merchants/most_revenue?quantity=x
   - GET /api/v1/merchants/most_items?quantity=x
   - GET /api/v1/revenue?start=<start_date>&end=<end_date>
   - GET /api/v1/merchants/:id/revenue

  

## Schema

![Alt](file:///Users/kevincuadros/Downloads/Untitled.pdf)

## Test Coverage

  - 100% 647/647 lines



