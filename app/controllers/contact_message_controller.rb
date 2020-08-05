
class ContactMessageController

    def self.all
        items = ContactMessages.scan()
        items
          .map { |r| { :name => r.name, :email => r.email, :context => r.context } }
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

end
