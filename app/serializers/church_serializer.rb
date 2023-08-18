class ChurchSerializer < ActiveModel::Serializer
    attributes :id, :title, :member_id,:church_details

    def church_details
      admin = Admin.find(object.admin_id)
      {
        name: admin.name
      }
    end
  end
  