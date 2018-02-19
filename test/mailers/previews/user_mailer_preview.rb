# To test ir go to localhost:3000/rails/mailers/purchase_mailer/name_of_the_method_below

class PurchaseMailerPreview < ActionMailer::Preview
  def purchase_notification_test
    client = Client.first
    invoice = Invoice.find(317)
    PurchaseMailer.purchase_notification(client, invoice)
  end
end
