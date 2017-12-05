//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require moment
//= require bootstrap-datetimepicker
//= require jquery.highchartTable
//= require highcharts
//= require_tree .

$(document).ready(function() {
  $('table.highchart').highchartTable();
});
