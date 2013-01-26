require 'csv'
  csv = CSV.open('/home/omri/millionsong/art_fact.csv','rb')
  csv.each do |row|
    Similarity.create({row[0].to_s,row[1].to_s)  
 end
 end   
  