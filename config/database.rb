require 'sequel'
require 'pg'

DB = Sequel.connect('postgres://davisfink@localhost:5432/eye_tyrant')
