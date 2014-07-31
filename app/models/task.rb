class Task < ActiveRecord::Base

  def as_json(options = {})
    attributes.slice(*%w(id name description updated_at))
  end

end