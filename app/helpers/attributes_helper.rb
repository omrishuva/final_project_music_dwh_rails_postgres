module AttributesHelper

	def get_tables_list(attributes)
		attributes.map(&:model_id).uniq
	end

end
