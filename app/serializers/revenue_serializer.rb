class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  set_id { nil }
  attribute :revenue do |object|
    object.total
  end
end
