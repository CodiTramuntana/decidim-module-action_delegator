# Decidim::ActionDelegator

![[CI] Build](https://github.com/coopdevs/decidim-module-action_delegator/workflows/%5BCI%5D%20Build/badge.svg)
[![Maintainability](https://api.codeclimate.com/v1/badges/6ec3c39e8dc2075808e1/maintainability)](https://codeclimate.com/github/coopdevs/decidim-module-action_delegator/maintainability)
[![Codecov](https://codecov.io/gh/coopdevs/decidim-module-action_delegator/branch/master/graph/badge.svg)](https://codecov.io/gh/coopdevs/decidim-module-action_delegator)


A tool for Decidim that provides extended functionalities for cooperatives.

Combines a CSV-like verification method with impersonation capabilities that allow users to delegate some actions to others.

Admin can set limits to the number of delegation per users an other characteristics.

Initially, only votes can be delegated.

> **NOTE** THIS IS IN DEVELOPMENT, NOT READY FOR USE IN PRODUCTION

## Dependencies

In order to use `decidim-action_delegator` you also need to install the [decidim-consultations](https://github.com/decidim/decidim/tree/develop/decidim-consultations) module.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "decidim-action_delegator", git: "https://github.com/coopdevs/decidim-module-action_delegator"
```

And then execute:

```bash
bundle
bundle exec rails decidim_action_delegator:install:migrations
bundle exec rails db:migrate
```

## Usage

ActionDelegator does not provides new Components or Participatory Spaces but enhances some functionalities in them.

### Extended consultation results

This gem modifies the consultation's results page adding two extra columns
`Membership type` and `Membership weight`. This requires a Decidim verification
that creates `decidim_authorizations` records which include the following JSON
structure in the `metadata` column:

```json
"{ membership_type: '', membership_weight: '' }"
```

See https://github.com/Platoniq/decidim-verifications-direct_verifications/pull/2
as an example of such verification.

### SMS gateway setup

In order to use this new sms gateway you need to configure your application. In config/initializers/decidim.rb set:

```ruby
config.sms_gateway_service = 'Decidim::ActionDelegator::SmsGateway'
```

Then you'll need to set the following ENV vars:

```bash
SMS_USER=
SMS_PASS=
SMS_SENDER= (optional)
```

This gateway uses Som Connexió as a provider which uses [this SOAP API](https://websms.masmovil.com/api_php/smsvirtual.wsdl).

## Contributing

See [Decidim](https://github.com/decidim/decidim).

### Developing

To start contributing to this project, first:

- Install the basic dependencies (such as Ruby and PostgreSQL)
- Clone this repository

Decidim's main repository also provides a Docker configuration file if you
prefer to use Docker instead of installing the dependencies locally on your
machine.

You can create the development app by running the following commands after
cloning this project:

```bash
bundle
DATABASE_USERNAME=<username> DATABASE_PASSWORD=<password> bundle exec rake development_app
```

Note that the database user has to have rights to create and drop a database in
order to create the dummy test app database.

Then to test how the module works in Decidim, start the development server:

```bash
cd development_app
DATABASE_USERNAME=<username> DATABASE_PASSWORD=<password> bundle exec rails s
```

In case you are using [rbenv](https://github.com/rbenv/rbenv) and have the
[rbenv-vars](https://github.com/rbenv/rbenv-vars) plugin installed for it, you
can add the environment variables to the root directory of the project in a file
named `.rbenv-vars`. If these are defined for the environment, you can omit
defining these in the commands shown above.

#### Code Styling

Please follow the code styling defined by the different linters that ensure we
are all talking with the same language collaborating on the same project. This
project is set to follow the same rules that Decidim itself follows.

[Rubocop](https://rubocop.readthedocs.io/) linter is used for the Ruby language.

You can run the code styling checks by running the following commands from the
console:

```
bundle exec rubocop
```

To ease up following the style guide, you should install the plugin to your
favorite editor, such as:

- Atom - [linter-rubocop](https://atom.io/packages/linter-rubocop)
- Sublime Text - [Sublime RuboCop](https://github.com/pderichs/sublime_rubocop)
- Visual Studio Code - [Rubocop for Visual Studio Code](https://github.com/misogi/vscode-ruby-rubocop)

### Testing

To run the tests run the following in the gem development path:

```bash
bundle
DATABASE_USERNAME=<username> DATABASE_PASSWORD=<password> bundle exec rake test_app
DATABASE_USERNAME=<username> DATABASE_PASSWORD=<password> bundle exec rspec
```

Note that the database user has to have rights to create and drop a database in
order to create the dummy test app database.

In case you are using [rbenv](https://github.com/rbenv/rbenv) and have the
[rbenv-vars](https://github.com/rbenv/rbenv-vars) plugin installed for it, you
can add these environment variables to the root directory of the project in a
file named `.rbenv-vars`. In this case, you can omit defining these in the
commands shown above.

### Test code coverage

If you want to generate the code coverage report for the tests, you can use
the `SIMPLECOV=1` environment variable in the rspec command as follows:

```bash
SIMPLECOV=1 bundle exec rspec
```

This will generate a folder named `coverage` in the project root which contains
the code coverage report.

## License

This engine is distributed under the GNU AFFERO GENERAL PUBLIC LICENSE.
