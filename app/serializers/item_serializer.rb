class ItemSerializer
  include JSONAPI::Serializer
  attributes  :name,
              :description,
              :unit_price,
              :merchant_id
  # def self.serialize(items)
  #   data = []
  #   items.each do |item|
  #     data << {name: item.name, descriptiong: item.description, unit_price: item.unit_price}
  #   end

  #   {data: data}
  # end
end