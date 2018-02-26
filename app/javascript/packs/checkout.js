import currencyFormatter from 'currency-formatter';

$("[data-invoice]").change(() => {
  const invoices = $("[data-invoice]:checked").toArray().map(el => JSON.parse(el.dataset.invoice));
  const total = invoices.reduce((sum, invoice) => sum + invoice.total_value_cents, 0);
  const interest = invoices.reduce((sum, invoice) => sum + invoice.average_interest_cents, 0);
  const ad_valorem = invoices.reduce((sum, invoice) => sum + invoice.average_ad_valorem_cents, 0);
  const iof = invoices.reduce((sum, invoice) => sum + invoice.iof, 0);
  const iof_ad = invoices.reduce((sum, invoice) => sum + invoice.iof_ad, 0);
  const deposit_value = invoices.reduce((sum, invoice) => sum + invoice.deposit_value, 0);

  $("#total").text(format(total));
  $("#interest").text(format(interest));
  $("#ad_valorem").text(format(ad_valorem));
  $("#iof").text(format(iof));
  $("#iof_ad").text(format(iof_ad));
  $("#deposit_value").text(format(deposit_value));

}).trigger("change");

function format(cents) {
  return currencyFormatter.format(cents / 100, { code: 'BRL' });
}
