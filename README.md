# README

A link shortener app written in Ruby on Rails.

### Ruby version
Ruby 2.5.0

### Rails version
Rails 5.1.6

### System dependencies
1. This app uses Redis cache. So make sure you start Redis before running the app.
2. Testing suite requires phantomjs to be installed. You can install it with
   homebrew on mac:
   ```
   brew install phantomjs
   ```

### How to run the test suite
```
rails test
rails test:system
```

### Scalability
This app can handle 1k urls a day with each getting hit 20k times a day by adding
the following caches:
1. A cache that stores the shortened URL with the long URL. No need to hit the
   database after first visit.
2. A cache that stores the usage counter. It will write back to db every 100
   visits.
3. A cache that stores the stat object. No need to hit the stat table for each
   visit.
