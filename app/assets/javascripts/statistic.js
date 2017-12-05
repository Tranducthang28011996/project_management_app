$(document).ready(function () {
  $('body').on('click', '.statistic-form', function(e){
    e.preventDefault();
    var url = window.location.pathname;
    var data_form = $(this).closest('form').serialize();
    $.ajax({
      url: url,
      type: 'POST',
      dataType: 'JSON',
      data: data_form
    })
    .done(function(data) {
      if (data.statistic_stattus === "new_record")
        window.location.reload()
      $('.view-chart').html(data.html)
      $('table.highchart').highchartTable();
    });
  });
});
