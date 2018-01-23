class AddAttachmentXmlToInvoices < ActiveRecord::Migration[5.1]
  def self.up
    change_table :invoices do |t|
      t.attachment :xml
    end
  end

  def self.down
    remove_attachment :invoices, :xml
  end
end
