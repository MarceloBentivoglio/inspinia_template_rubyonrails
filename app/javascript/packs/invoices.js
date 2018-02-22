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
  const invoices = $(".invoices-batch:checked").toArray().map(e => parseInt(e.value));

  checkout.toggleClass("disabled", invoices.length === 0);
  checkout.attr("href", `/invoices/checkout?invoices_ids=${JSON.stringify(invoices)}`);
})
