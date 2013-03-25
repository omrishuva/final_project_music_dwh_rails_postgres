class Attribute < ActiveRecord::Base
	attr_accessible :attribute_name, :attribute_type, :table_id
end
