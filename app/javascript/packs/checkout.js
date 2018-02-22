import currencyFormatter from 'currency-formatter';

$("[data-invoice]").change(() => {
  const invoices = $("[data-invoice]:checked").toArray().map(el => JSON.parse(el.dataset.invoice));
  const total = invoices.reduce((sum, invoice) => sum + invoice.total_value_cents, 0);
  const taxes = invoices.reduce((sum, invoice) => sum + invoice.taxes, 0);

  $("#total").text(format(total));
  $("#taxes").text(format(taxes));
}).trigger("change");

function format(cents) {
  return currencyFormatter.format(cents / 100, { code: 'BRL' });
}
