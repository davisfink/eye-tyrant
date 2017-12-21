require 'sequel'
require 'mysql'

DB = Sequel.connect('mysql://root@localhost:3306/eye_tyrant')
