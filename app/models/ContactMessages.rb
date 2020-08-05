class ContactMessages
    include Aws::Record
    string_attr :id, hash_key: true
    string_attr :email
    string_attr :name
    string_attr :context
    epoch_time_attr :created_at
    epoch_time_attr :updated_at
  end
