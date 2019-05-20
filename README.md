
Today's code: https://github.com/NimaBoscarino/rspec-notes

Some links from lecture:

https://stackoverflow.com/questions/4343435/how-do-i-load-seed-rb-within-a-rails-test-environment-using-rpec

https://medium.freecodecamp.org/a-comparison-of-the-top-orms-for-2018-19c4feeaa5f

https://github.com/garrettgsb/react-express-boilerplate

https://github.com/NimaBoscarino/react-rails-boilerplate

https://github.com/NimaBoscarino/react-redux-boilerplate

I stole Karl's notes!!

Karl's Slides and notes available at [https://github.com/jensen/testing-notes/](https://github.com/jensen/testing-notes/)

We've brought up testing. Week one with JavaScript using [Mocha](https://mochajs.org/) and [Chai](https://www.chaijs.com/). We know that testing is an important part of software development. Why didn't we see more over the last seven weeks?

The primary reason is time. Testing takes time and effort. You have to learn how to test. One good way to do that is to test your software manually. This is what you have been doing up until now. Today we will use code to instruct the application to test itself.

## Learning to Test

Testing is a skill that is learned. I think it's common to assume that everyone who can use software can also test software. Think about some of the things that you have learned about testing that you did not know when you started learning software development.

## Types of Testing

- Unit Testing
- Feature Testing
- End-to-End Testing
- Integration Testing
- A/B Testing
- Regression Testing
- Acceptance Testing
- Etc..

There are a lot of terms used when trying to describe the types of testing we can use. Some of them represent the same idea (Feature/Integration/End-to-End), others aren't about testing the stability of the software (A/B). 

### Unit Testing

Isolated to the smallest testable part of an application. Typically this is a function.

### Feature Testing (Integration, End-to-End)

Simulates user interaction to test how separate pieces work together. Typically this is run in a production-like environment.

### A/B Testing

An approach for testing user experience practices. Some users are served a different version of the site to test conversion.

### Regression Testing

The re-testing of previously found bugs to ensure they do not return.

### Acceptance Testing

These types of tests will determine compliance of the software with business requirements.

## Test-Driven Development (TDD)

### What is TDD?

The goal of Test-Driven Development is "Clean code that works". There are a number of benefits that come with clean code that works. It would be hard to argue against clean code given the choice.

In the book "Test-Driven Development By Example" by Kent Beck it is suggested that we follow two rules:

1. Write new code only if an automated test has failed
2. Eliminate duplication

These rules have implications on our behaviour in the generation of work. We need to design organically, get immediate feedback on small changes, write our own tests and design testability into the architecture.

You may have heard reference to red/green/refactor. This process is at the core of TDD.

1. Red - Write a small test that doesn't pass
2. Green - Do the minimal amount of work to make the test pass
3. Refactor - Improve the code, continuing to ensure all tests still pass

### Courage

Kent explains that the reason we want to use TDD is "Courage".

Fear makes us tentative, less communicative and feedback averse. Having tests that tell us the software we are writing works gives us courage. With courage we will learn quickly, communicate clearly and search out feedback. 

I notice early on with new students that it takes a long time to get to a solution that works Once you have working code you are afraid of changing it in case it breaks. The red/green/refactor process is a good way to get comfortable with changing your code. Refactoring is the path to clean code.

[Reference](https://en.wikipedia.org/wiki/Test-driven_development)

### Behaviour Driven Development (BDD)

Behaviour Driven Development is an approach that requires a partnership between the business and the technology. It emerged from TDD. You may notice that tools will use a Domain Specific Language (DSL) that reads like a user story.

An example of a popular tool is [Cucumber](https://docs.cucumber.io/). It's a lot to ask non technical people to work in this way. Writing tests takes a certain perspective.

## Code Coverage

With automated testing we can track what percentage of our code is executed by running our tests. Some tools that can be used to track this metric.

- [simplecov](https://github.com/colszowka/simplecov)
- [Coveralls](https://coveralls.io/)

The target is project based. A lot of factors go into deciding what your target is. There are classifications of code that don't need tests. As you are going through the exercises to test the Jungle Rails project, think about the relative importance of the tests.

## Environments

With JavaScript and Node we can configure an application to behave differently based on the environment it is running in. This is no different with Rails. The environment variable `RAILS_ENV` is commonly set to `development`, `test`, `production`.

We will use this configuration to:

- Only use certain gems in specific environments
- Separate our development, production and testing databases

## Setting up a Project

With Jungle you were asked to start working on an already existing project. We can start a new rails project and configure it in a similar way to the existing Jungle project.

### Ruby

In most circumstances you want to be using the latest version of Ruby when you start a new project. How do we know what version we are on?

`ruby -v`

If there is a newer version then use [rbenv](https://github.com/rbenv/rbenv) or [rvm](https://rvm.io/) to install it. The VM that you have been using already has rvm setup.

### Rails

Gems are installed for the current version of ruby. The latest version of rails can be installed with `gem install rails`.

This provides us with the `rails` command that will allow us to create a new project in addition to other things.

We wouldn't be happy with the default project that `rails new` creates. 

1. We want to use RSpec instead of the TestUnit library.
2. We want to use PostgreSQL instead of SQLite.

Using the `-T` flag we can remove testing, so that we can decide what gem to install for this. Using the `-db` flag we can specify the relational database implementation to use. With all of these considerations, the command to run is `rails new <project name> -T -d postgresql`.

We have decided to use [RSpec](http://rspec.info/) as a test runner. This is a popular choice for Ruby projects.

### rspec-rails

Since the creation of the project excluded the TestUnit gem we will replace it with [rspec-rails](https://github.com/rspec/rspec-rails). Following instructions from the documentation we get a clue about the use of environments and depdencies. Only use `rspec-rails` in the development or test environment. This makes sense that we wouldn't load this code into a production application.

> Gemfile

```ruby
group :development, :test do
  gem 'rspec-rails', '~> 3.8'
end
```

After updating the Gemfile you can install new gems by running `bundle install`. Gems can configure special use generators. One of those generators will create the `spec/` directory and a couple of helper files.

`rails generate rspec:install`

You can see the other RSpec generators by running `rails g`.

### Running RSpec

Examples will use `rspec`, `bin/rspec`, `bundle exec rspec`.

The first one works if the PATH environment variable is configured to point to your ruby `bin` directory. 

In order to get the `bin/rspec` command to work you would install binstubs with `bundle binstubs rspec-core`. This is good if you want to use different versions of rspec for different projects.

[Bundler](https://bundler.io/man/bundle-exec.1.html) will let us run command within the context of the bundle. With `bundle exec rspec` we let bundler find the rspec command to run based on our Gemfile.

Some tests will take longer to run than others. In order to be more specific rspec can take in a parameter that tells it which spec file to run.

```bash
# Run only model specs
bundle exec rspec spec/models

# Run only specs for AccountsController
bundle exec rspec spec/controllers/accounts_controller_spec.rb

# Run only spec on line 8 of AccountsController
bundle exec rspec spec/controllers/accounts_controller_spec.rb:8
```

### Creating a Model

Creating a model is the same as it was before. 

`rails g model Product name:string price:integer quantity:integer`

When the [generators](https://github.com/rspec/rspec-rails#generators) are run the project is now configured to create spec files instead of Test::Unit test files. 

## Setup DB

This is a brand new project so it is required that we create a database, and then migrate our development. We should run the migration for the test db as well so the schema matches what is expected when run using `RAILS_ENV=test`.

```bash
rails db:create
rails db:migrate #(default)
rails db:migrate RAILS_ENV=test
```

Remember that it is important for us to have a database used solely for testing. This database needs to be reset after every test to ensure that the test is independent.

## Writing the first tests

We will write tests for three parts of the model today. 

1. Validations
2. Instance Methods
3. Class Methods

We would like to use TDD. This means that we need to write the tests before we write that code that is being tested. 

### Validations

Validations are a great thing to test for. We want to make sure a Product can be created with valid attributes. If any of the required attributes are missing thethen the product should not be created.

```ruby
describe "Validations" do
  it "is not valid without a name" do
    product = Product.new(
      name: nil,
      price: 1,
      quantity: 1
    )

    expect(product).to_not be_valid
  end
end
```

### Instance Methods

The sold out feature can be implemented by adding a sold_out? method to the Product model. This is a great place to have this logic. What does it mean to be sold out? We determine that when we write the tests.

```ruby
describe "#sold_out?" do
  it "is sold out if there are 0 left" do
    product = Product.create(
      name: 'Item',
      price: 1,
      quantity: 0
    )

    expect(product.sold_out?).to be true
  end
end
```

### Class Methods

Maybe we want to create a section of the site where it shows products that have a low stock. While we are writing the tests we decide what it means to be low on stock. In this case when we only have one or two remainting.

```ruby
describe ".low_stock" do
  it "returns the products with a quantity less than 3" do
    Product.create(name: 'Item', price: 1, quantity: 1)
    Product.create(name: 'Item', price: 1, quantity: 2)
    Product.create(name: 'Item', price: 1, quantity: 3)

    products = Product.low_stock()

    expect(products.length).to be 2
  end
end
```

### The Pattern of Testing

I hope that you are seeing a clear pattern with this process. 

1. First setup the context
2. Then trigger the execution of the code you are testing
3. Then check that the new state is expected
4. Finally, clean up so another test can run

## Before :each, Before :all

It's important to understand some of the dangers of using `before :each` and `before :all`. Anything created as an instance variable in the `before :all` will persist for all the tests. Normally the intention is that all tests need a product so you can create it once and use it within your tests. This can be done with `before :each`. This way the instance is created for each test and no state is retained across tests. See the example code in `project/spec/models/product_spec.rb` for more details.

## Database

Take a look at the testing database with `rails db test`. Notice that there are no records. The database is cleared between every test. This is important. Each test must be able to run independetly. The order that tests are run in must not matter.

## Improving

This is an introduction to testing and a preview of the work that will be done today. If you are interesetd in getting better at writing better rspec tests in ruby then check out [http://www.betterspecs.org/](http://www.betterspecs.org/).

## Bonus

I would like to point out something I have noticed while learning Ruby and Rails. Ruby on Rails is over 10 years old. There have been 5 major releases in that time. The framework changes, but tutorials written 5 years ago don't get updated. When looking for examples online be careful of the age of the example.

While confirming the validation of presence I found three ways described.

1. `validates_presences_of :product` which seems to be deprecated since Rails 3.
2. `validates :name, :presence => true` which would no longer be ideal since Ruby 1.9 reduced usage of 'hash rocket' syntax.
3. `validates :name, presence: true` which seems to be the preferred way with the newer JSON style syntax.

I recommend keeping an eye on the date of instructional content and as much as possible __consult official documentation__.