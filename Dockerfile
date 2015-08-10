FROM rails:onbuild

RUN rake db:migrate
RUN RAILS_ENV=production rake db:migrate
