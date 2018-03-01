source 'https://rubygems.org'
ruby '2.3.5'

gem 'devise'
gem 'figaro'
gem 'jbuilder', '~> 2.0'
gem 'pg', '~> 0.21'
gem 'puma'
gem 'rails', '5.1.4'
gem 'redis'

gem 'autoprefixer-rails'
gem 'bootstrap-sass'
gem 'font-awesome-sass'
gem 'sass-rails'
gem 'simple_form'
gem 'uglifier'
gem 'jquery-rails'
gem 'webpacker'


# The gems bellow were installad by us after Le Wagon template:

#   This gem treats money as cents in integer with the respective currency
gem 'money-rails', '~> 1' #https://github.com/RubyMoney/money-rails

#   This gem is used to make nested-models forms, e.x: the form of operation has the intallments obejtcs inside https://github.com/nathanvda/cocoon
gem 'cocoon'

#   This gem is used to upload documents using a form
gem "paperclip"

# This gem is used to calculate between dates
gem 'time_difference'

# This gem is used to read xlsx files so that we can convert the data inside the file into ruby objects
gem 'creek'

# This gem is used to group data from the database by date. We use it for manking active record requests and group them to put on charts.
gem 'groupdate', '~> 2.5', '>= 2.5.2'

# This gem is used to build Admin interface. Github reference still needed because of Rails 5 support.
gem 'activeadmin', github: 'activeadmin/activeadmin'
gem 'inherited_resources', github: 'activeadmin/inherited_resources'

# This gem is used to enable enum to become a selection in simple_form. We use it especially on the rejections form
gem 'enum_help'

group :development do
  gem 'web-console', '>= 3.3.0'
  # This gems was taught in Le Wagon and it is used to open the mail sent by the app on a tab of the browser
  gem "letter_opener"
end

group :development, :test do
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'rack-mini-profiler'

  # For memory profiling (requires Ruby MRI 2.1+)
  gem 'memory_profiler'

  # For call-stack profiling flamegraphs (requires Ruby MRI 2.0.0+)
  gem 'flamegraph'
  gem 'stackprof'     # For Ruby MRI 2.1+
  gem 'fast_stack'    # For Ruby MRI 2.0
  # gem 'bullet'
end
