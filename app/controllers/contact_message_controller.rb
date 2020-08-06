class ContactMessageController

    def self.list
        items = ContactMessages.scan()
        items
          .map { |r| { :id => r.id, :name => r.name, :email => r.email, :context => r.context } }
          .sort { |a, b| a[:created_at] <=> b[:created_at] }
          .to_json
    end

    def self.create(params)
        item = ContactMessages.new(id: SecureRandom.uuid, created_at: Time.now, updated_at: Time.now )
        item.email = params[:email]
        item.name = params[:name]
        item.context = params[:context]
        item.save!
        item
    end

    def self.find_by_id( id )
      item = ContactMessages.find(id: id)
      item.to_h.to_json
    end

    def self.find_by_email( email )
      item = ContactMessages.query(
        key_condition_expression: "#A = :a",
        expression_attribute_names: {
          "#A" => "email"
      },
        expression_attribute_values: {
          ":a" => email
        }
      )
      item.to_json
    end
end
