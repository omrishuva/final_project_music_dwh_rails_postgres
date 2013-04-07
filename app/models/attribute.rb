class Attribute < ActiveRecord::Base
  attr_accessible :attribute_name, :attribute_type, :table_id
	belongs_to :table
  has_many :attribute_category_relations
  has_many :attribute_categories ,:through => :attribute_category_relations

 #  	def place_in_groups!(groups)
	# 	 groups.each do |group|
	# 	 	results = { objects: @data.select{ |d| d[@fact_subject]>group[:min] && d[@fact_subject]<group[:max] } } 
	# 		results.merge!( { count: results[:objects].size } )
	# 		group.merge!(results)
	# 	end	
	# end	

	#aggregations

	def sum
		@sum ||= table_obj.sum(attribute_name)
	end

	def count
		@count ||= table_obj.count(attribute_name)
	end	

	def max
		@max ||= table_obj.maximum(attribute_name)
	end

	def min
		@min ||= table_obj.minimum(attribute_name)
	end

	def avg
		@avg ||= table_obj.average(attribute_name)
	end	

	def aggregations( actions )
		rslt = table_obj.select(actions.map{ |action| "#{action}(#{attribute_name}) AS #{action} " }.join(",") ).first
		binding.pry
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
