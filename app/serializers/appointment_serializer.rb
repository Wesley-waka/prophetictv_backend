class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :title, :member_id
end
