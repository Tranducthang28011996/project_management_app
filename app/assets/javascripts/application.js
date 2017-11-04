//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .

$(document).ready(function(){
  // Toggle Function
  $('.toggle').click(function(){
    $('.alert' ).fadeOut(1000);
    // Switches the Icon
    $(this).children('i').toggleClass('fa-pencil');
    // Switches the forms  
    $('.form').animate({
      height: 'toggle',
      'padding-top': 'toggle',
      'padding-bottom': 'toggle',
      opacity: 'toggle'
    }, 'slow');
  });

  $('.alert' ).fadeOut(3000);
  $('#error_explanation').fadeOut(3000);
});

$(function() {
  $('.connected').sortable({
    connectWith: '.connected'
  });
  $('.connected').on('drop', function(ev){
    console.log($(this).attr('id'));
  });

  // $('.connected').on('dragenter', function(ev){
  //       //   console.log($(this).attr('id'));
  //             // });
  //
  $('.task-item').on('dragstart', function(ev){
    console.log($(this).attr('id'));
  });
});
