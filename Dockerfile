FROM ruby:2.5.1

WORKDIR /identity_api

COPY Gemfile Gemfile.lock  ./

RUN bundle install

COPY . . 

CMD ["bundle", "exec", "rails", "s"]
