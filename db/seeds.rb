# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'
  i=0
  csv = CSV.open('/home/omri/millionsong/csvfiles/finals/Uniq_terms.csv','rb')
  csv.each do |row|
    term = Term.find(row[0])
    p term.term.to_s + " " + row[2].to_s  
    term.category = row[2] if row[2]
    term.save
  end  
  