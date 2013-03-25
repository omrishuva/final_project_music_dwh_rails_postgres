
namespace :attributes do
  task :update => :environment do 


Table.all.each do |table|
  
    attributes =  eval(table.name).columns
    attributes.each do |attribute|
      Attribute.create(
        attribute_name: attribute.name,
        attribute_type: attribute.type.to_s,
        table_id: table.id
      )			
    end	
  end	

end
end  