class SermonSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :admin_details

  def admin_details
    admin = Admin.find(admin_id)
    {
      name: admin.name
    }
  end
end
