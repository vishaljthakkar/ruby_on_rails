# README
* Commands executed
1. rails new fancy_car
2. rails generate scaffold car make color year:integer
3. rake db:migrate # to populate the database sqlite => database.yml specifies the location of db file.
4. rails db # This connects to sqlite.
5. rake db:rollback # This command undoes last migration
6. rails generate migration add_price_to_cars 'price:decimal{10,2}'  # This command addes column with class name 'AddPriceToCars' column name: price of type decimal with scale and precision
7. rails generate migration rename_make_to_company # rename table column
