// const rows = document.querySelectorAll("tr");

// rows.forEach(row => {
//   row.addEventListener("click", event => {
//     console.log("Clicked on:", event.currentTarget);
//   });
// })

$("[data-load-invoice]").click(event => {
  const row = event.currentTarget;
  const invoiceId = row.dataset.loadInvoice;

  $.get(`/invoices/${invoiceId}`).then(invoiceHTML => {
    $("#invoice-panel")
      .html(invoiceHTML)
      .find('.full-height-scroll')
      .slimscroll({
          height: '100%'
      });
  });
});

$(".invoices-batch").change(() => {
  const checkout = $("#checkout-batch");
  const rejection = $("#rejection-batch");
  const not_available = $("#not-available-batch");
  const available = $("#available-batch");
  const remove = $("#remove-batch");
  const invoices = $(".invoices-batch:checked").toArray().map(e => parseInt(e.value));

  checkout.toggleClass("disabled", invoices.length === 0);
  rejection.toggleClass("disabled", invoices.length === 0);
  not_available.toggleClass("disabled", invoices.length === 0);
  available.toggleClass("disabled", invoices.length === 0);
  remove.toggleClass("disabled", invoices.length === 0);
  checkout.attr("href", `/invoices/checkout?invoices_ids=${JSON.stringify(invoices)}`);
  rejection.attr("href", `/invoices/rejection?invoices_ids=${JSON.stringify(invoices)}`);
  not_available.attr("href", `/invoices/not_available?invoices_ids=${JSON.stringify(invoices)}`);
  available.attr("href", `/invoices/available?invoices_ids=${JSON.stringify(invoices)}`);
  remove.attr("href", `/invoices/remove?invoices_ids=${JSON.stringify(invoices)}`);
})

