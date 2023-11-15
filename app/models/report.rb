class Report < ApplicationRecord
  belongs_to :reporter, class_name: "Customer"
  belongs_to :reported, class_name: "Customer"
  
  def self.reported_count(customer_id)
    where(reported_id: customer_id).count
  end
end
