class Attribute < ActiveRecord::Base
  attr_accessible :attribute_name, :attribute_type, :table_id, :actions
  belongs_to :table
  has_many :attribute_category_relations
  has_many :attribute_categories ,:through => :attribute_category_relations
  serialize :dim_actions, Array
  serialize :fact_actions, Array
  before_save :add_actions
 #  	def place_in_groups!(groups)
	# 	 groups.each do |group|
	# 	 	results = { objects: @data.select{ |d| d[@fact_subject]>group[:min] && d[@fact_subject]<group[:max] } } 
	# 		results.merge!( { count: results[:objects].size } )
	# 		group.merge!(results)
	# 	end	
	# end	

	#aggregations

	def add_actions
		if attribute_type == "float" || attribute_type == "integer"
			self.fact_actions = [ "sum", "avg" , "count" ]
			self.dim_actions  = [ ">", "<" , "=" ]
		elsif attribute_type == "string"
			self.fact_actions = ["count"]
			self.dim_actions = ["=" ,"IN","group" ]
		end
	end
	
	def aggregations( actions )
		rslt = table_obj.select(actions.map{ |action| "#{action}(#{attribute_name}) AS #{action} " }.join(",") ).first
		final_result = {}
		actions.each do |action|
			final_result.merge!(action.to_sym => rslt.send(action)) 
		end
	final_result
	end	

#pre query actions
	def discrete ( group_num = 5  )
		max = table_obj.maximum(attribute_name)
		min = table_obj.minimum(attribute_name)
		diff = (max - min)/group_num
		
		groups = []
		groups << { min: min , max: min + diff }

		(group_num -1).times.with_index do |idx|
			groups << { min: groups[idx][:max] , max: groups[idx][:max] + diff }
		end	
		groups
	end

#utils
	def table_obj
		eval(table.name)
	end	

end
