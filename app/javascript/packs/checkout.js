const currencyFormatter = require('currency-formatter');

$("[data-invoice]").change(() => {
  const invoices = $("[data-invoice]:checked").toArray().map(el => JSON.parse(el.dataset.invoice));
  const total = invoices.reduce((sum, invoice) => sum + invoice.total_value_cents, 0);
  const interest = invoices.reduce((sum, invoice) => sum + Number(invoice.interest.fractional), 0);
  const ad_valorem = invoices.reduce((sum, invoice) => sum + Number(invoice.ad_valorem.fractional), 0);
  const iof = invoices.reduce((sum, invoice) => sum + Number(invoice.iof.fractional), 0);
  const iof_ad = invoices.reduce((sum, invoice) => sum + Number(invoice.iof_ad.fractional), 0);
  const deposit_value = invoices.reduce((sum, invoice) => sum + Number(invoice.deposit_value.fractional), 0);

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
