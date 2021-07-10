# Upgrading Rails 5.2.5 to 6.0.0

## Update active_model_serializers gem
  * Run `$ bundle update active_model_serializers` to avoid the fowling error on bundle update rails:
  ```
    Bundler could not find compatible versions for gem "actionpack":
    In Gemfile:
      actionpack (~> 6.0.1)

      active_model_serializers (~> 0.10.0) was resolved to 0.10.7, which depends on
        actionpack (< 6, >= 4.1)

      rspec-rails was resolved to 3.8.0, which depends on
        actionpack (>= 3.0)
  ```

## Update rails gem
  * Modify Gemfile to `gem 'rails', '~> 6.0.0'`
  * Run `$ bundle update rails`

## Update sqlite3 gem
  * Run `$ bundle update sqlite3` to avoid the fowlling error on run `rails db:prepare`:
  ```
  Caused by:
    Gem::LoadError: can't activate sqlite3 (~> 1.4), already activated sqlite3-1.3.13. Make sure all dependencies are added to Gemfile.
  ```