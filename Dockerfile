FROM seapy/rails-nginx-unicorn

RUN RAILS_ENV=production rake db:migrate

EXPOSE 80

