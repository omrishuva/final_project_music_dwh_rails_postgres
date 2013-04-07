class Table < ActiveRecord::Base
	attr_accessible :name
	has_many :attributes
	has_many :fact
	has_many :star_dims
	has_many :snow_dims

#queries
	def aggregations_query( args )
		add_as_key!(args)
		if args[:fact].keys.include? :where
			rslt = obj.where(where_string(args[:fact][:where])).select(select_string(args[:fact][:actions])).first		
		else
			rslt = obj.select(select_string(args[:fact][:actions])).first
		end
		format_results(rslt, args)
	end

	def star_query
		@fact.where(@fact_filters[:attribute]=> @fact_filters[:ids])
	end
	
	def snow_query
		obj.joins(@fact_where[:dim])
		.where("#{@fact_where[:attribute]} IN (#{@fact_where[:ids]})")
	end

	#utils################################3
		
	def format_results(rslt,args)
		final_result = {}
		args[:fact][:actions].keys.each do |key|
			result_name =  args[:fact][:actions][key][:as]
			final_result.merge!(result_name => rslt.send(result_name))
		end
		final_result
	end

	def add_as_key!(args)
		args[:fact][:actions].keys.each do |key|
			args[:fact][:actions][key].merge!( as: "#{args[:fact][:actions][key][:function]}_#{key}" )
		end	
		args
	end	

	def where_string( args )
		where_string = args.keys.map do |key|
		 "#{key} #{args[key][:operator]} #{args[key][:value]} "
		end
		where_string.join(" AND ")
	end	

	def select_string(args)
		select_string = args.keys.map do |key|
		 "#{args[key][:function]}(#{key}) AS #{args[key][:as]} "
		end
		select_string.join(",")
	end	

	def obj
		@obj ||= eval(name)
	end	

end
