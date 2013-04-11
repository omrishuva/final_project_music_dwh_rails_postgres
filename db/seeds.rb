#require 'csv'
#  term_ids = Term.select(:id).map(&:id)
#  term_ids.each do |id| 
#   p id
#   terms = ArtistTerm.where(term_id:id) 
#   p terms.first.name
#   p terms.first.term_id
#   terms.each do |t|
#     t.category = Term.find(id).category       
#     p "-------------------------------------------"
#     t.save
#   end 
# end

# artists = Artist.all
# artists.each do |artist|
# p artist[:artist_name].to_s + " " + artist.similarities.count(:artist_id).to_s
# artist.similars_count = artist.similarities.count
# artist.save
# end	
# artist_albums = ArtistAlbums.all
# index =1
# artist_albums.each do |aa|
#   aa.temp = index
#   aa.save
#   index+=1	
# end

t1=Table.find 6
 	
 args1=	{ fact:{
	 	 				aggregations:{
	 	 					id:{ function: 'count'},
	 	 					artist_hotness:{ function: 'avg'},
	 	 					artist_fam:{ function: 'avg'},
	 	 				},
	 	 				where:{
				 	 		artist_fam:{
				 	 			operator:">",
				 	 			value: 0
				 	 		},
				 	 		artist_hotness:{
				 	 			operator:">",snow_dim
				 	 			value: 0
				 	 		}
 				 	 	}
 	 				},
 					
 					dims:{
 						artist_terms:{
 							where:{
								freq:{
									operator:">",
	 								value: "0.8"
								}		
							},	
 							snow_dim:{
 								terms:{
	 								where:{
	 									term:{
	 										operator:"IN",
											value: ["dub","reagge","mento"]	
	 									}
	 								}
 								}
 							}	
 						}
					}	
				}	
 			
t2=Table.find 3

args2=	{ fact:{
	 	 				aggregations:{
	 	 					song_id:{ function: 'count'},
	 	 					song_hot:{ function: 'avg'},
	 	 				},
	 	 				where:{
				 	 		song_hot:{
				 	 			operator:">",
				 	 			value: 0
				 	 		},		
 				 	 	}
 	 				},
 					
 					dims:{
 						artist:{
 							where:{
								artist_name:{
									operator:"IN",
	 								value: ['the doors', 'the clash', 'jimi hendrix']
								}		
							}		
 						}
					}	
				}	


 	binding.pry
  Query.create(args1, t1.fact)
  