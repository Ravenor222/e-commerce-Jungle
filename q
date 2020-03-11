[1mdiff --git a/app/models/user.rb b/app/models/user.rb[m
[1mindex d3624bc..a25557e 100644[m
[1m--- a/app/models/user.rb[m
[1m+++ b/app/models/user.rb[m
[36m@@ -5,7 +5,7 @@[m [mclass User < ActiveRecord::Base[m
     validates :password, presence: true, length: { minimum: 5 }[m
 [m
     def self.authenticate_with_credentials(email,password)[m
[31m-        user = User.find_by_email(email)[m
[32m+[m[32m        user = User.find_by_email(email.strip.downcase)[m
 [m
         if user && user.authenticate(password)[m
             user[m
[1mdiff --git a/spec/support/database_cleaner.rb b/spec/support/database_cleaner.rb[m
[1mindex c38f665..322cedb 100644[m
[1m--- a/spec/support/database_cleaner.rb[m
[1m+++ b/spec/support/database_cleaner.rb[m
[36m@@ -1,45 +1,44 @@[m
 RSpec.configure do |config|[m
 [m
[31m-    config.before(:suite) do[m
[31m-      if config.use_transactional_fixtures?[m
[31m-        raise(<<-MSG)[m
[31m-          Delete line `config.use_transactional_fixtures = true` from rails_helper.rb[m
[31m-          (or set it to false) to prevent uncommitted transactions being used in[m
[31m-          JavaScript-dependent specs.[m
[31m-  [m
[31m-          During testing, the app-under-test that the browser driver connects to[m
[31m-          uses a different database connection to the database connection used by[m
[31m-          the spec. The app's database connection would not be able to access[m
[31m-          uncommitted transaction data setup over the spec's database connection.[m
[31m-        MSG[m
[31m-      end[m
[31m-      DatabaseCleaner.clean_with(:truncation)[m
[31m-    end[m
[31m-  [m
[31m-    config.before(:each) do[m
[31m-      DatabaseCleaner.strategy = :transaction[m
[31m-    end[m
[31m-  [m
[31m-    config.before(:each, type: :feature) do[m
[31m-      # :rack_test driver's Rack app under test shares database connection[m
[31m-      # with the specs, so continue to use transaction strategy for speed.[m
[31m-      driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test[m
[31m-  [m
[31m-      if !driver_shares_db_connection_with_specs[m
[31m-        # Driver is probably for an external browser with an app[m
[31m-        # under test that does *not* share a database connection with the[m
[31m-        # specs, so use truncation strategy.[m
[31m-        DatabaseCleaner.strategy = :truncation[m
[31m-      end[m
[31m-    end[m
[31m-  [m
[31m-    config.before(:each) do[m
[31m-      DatabaseCleaner.start[m
[32m+[m[32m  config.before(:suite) do[m
[32m+[m[32m    if config.use_transactional_fixtures?[m
[32m+[m[32m      raise(<<-MSG)[m
[32m+[m[32m        Delete line `config.use_transactional_fixtures = true` from rails_helper.rb[m
[32m+[m[32m        (or set it to false) to prevent uncommitted transactions being used in[m
[32m+[m[32m        JavaScript-dependent specs.[m
[32m+[m
[32m+[m[32m        During testing, the app-under-test that the browser driver connects to[m
[32m+[m[32m        uses a different database connection to the database connection used by[m
[32m+[m[32m        the spec. The app's database connection would not be able to access[m
[32m+[m[32m        uncommitted transaction data setup over the spec's database connection.[m
[32m+[m[32m      MSG[m
     end[m
[31m-  [m
[31m-    config.append_after(:each) do[m
[31m-      DatabaseCleaner.clean[m
[32m+[m[32m    DatabaseCleaner.clean_with(:truncation)[m
[32m+[m[32m  end[m
[32m+[m
[32m+[m[32m  config.before(:each) do[m
[32m+[m[32m    DatabaseCleaner.strategy = :transaction[m
[32m+[m[32m  end[m
[32m+[m
[32m+[m[32m  config.before(:each, type: :feature) do[m
[32m+[m[32m    # :rack_test driver's Rack app under test shares database connection[m
[32m+[m[32m    # with the specs, so continue to use transaction strategy for speed.[m
[32m+[m[32m    driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test[m
[32m+[m
[32m+[m[32m    if !driver_shares_db_connection_with_specs[m
[32m+[m[32m      # Driver is probably for an external browser with an app[m
[32m+[m[32m      # under test that does *not* share a database connection with the[m
[32m+[m[32m      # specs, so use truncation strategy.[m
[32m+[m[32m      DatabaseCleaner.strategy = :truncation[m
     end[m
[31m-  [m
   end[m
[31m-  [m
\ No newline at end of file[m
[32m+[m
[32m+[m[32m  config.before(:each) do[m
[32m+[m[32m    DatabaseCleaner.start[m
[32m+[m[32m  end[m
[32m+[m
[32m+[m[32m  config.append_after(:each) do[m
[32m+[m[32m    DatabaseCleaner.clean[m
[32m+[m[32m  end[m
[32m+[m
[32m+[m[32mend[m
\ No newline at end of file[m
