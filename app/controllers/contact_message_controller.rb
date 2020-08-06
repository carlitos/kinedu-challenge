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

    def self.get_by_id(params)
      
      item.id = params.id
      item = ContactMessages.find(item.id)
      item.to_json
    end

    # def self.find_by_email(params)
    #   item = ContactMessages.Book.find(:all, :where => 'email = "nrubio@congresogto.gob.mx"')
    #   item.to_json
    # end

end
