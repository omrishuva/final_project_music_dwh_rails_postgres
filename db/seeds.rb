# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'
  i=0
  csv = CSV.open('/home/omri/millionsong/csvfiles/finals/terms.csv','rb')
  csv.each do |row|
    term = Term.find(row[0])
     p term.term.to_s + " " + row[2].to_s  
     term.category = row[2] if row[2]
   
   #  avg = term.artist_terms
   #  .select("AVG(freq) AS freq, AVG(weight) AS weight ,COUNT(*) AS count ")
   #  p term.term
   #  p avg[0].freq
   #  p avg[0].weight
   #  p avg[0].count
   #  p "----------------------------------------------------"
  	# term.freq_avg = avg[0].freq
  	# term.weight_avg = avg[0].weight
  	# term.count  = avg[0].count
  	term.save   
  end  
  