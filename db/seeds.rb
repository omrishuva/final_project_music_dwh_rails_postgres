
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
				 	 			operator:">",
				 	 			value: 0
				 	 		}
 				 	 	},
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
	 								},
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


 	
 	q1 = Query.create(args1, t1.fact)
  q2 = Query.create(args2, t2.fact)
  binding.pry
  p q1.args['where']
  p q1.args['select']
  p q1.execute
  p"-"*150
  p"-"*150
  p q2.args['where']
  p q2.args['select']
  p q2.execute
  