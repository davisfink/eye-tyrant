require 'sequel'
#require 'pg'
require 'mysql'

DB = Sequel.connect('mysql://root@localhost:3306/eye_tyrant')
#DB = Sequel.connect('postgres://davisfink@localhost:5432/eye_tyrant')
