class PurchaseMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.purchase_notification.subject
  #
  def purchase_notification(client, order)
    @greeting = "Olá"
    @client = client
    @invoices = []
    order.invoices.each { |i| @invoices << i }

    mail(
      to: "joaquim.oliveira.nt@gmail.com",
      subject: "[Advalori] Alguém comprou um título!"
    )
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.purchase_confirmation.subject
  #
  def purchase_confirmation
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
