$(document).ready(function(){
  $('.toggle').click(function(){
    $('.alert' ).fadeOut(1000);
    $(this).children('i').toggleClass('fa-pencil');
    $('.form').animate({
      height: 'toggle',
      'padding-top': 'toggle',
      'padding-bottom': 'toggle',
      opacity: 'toggle'
    }, 'slow');
  });

  $('.alert' ).fadeOut(3000);
  $('#error_explanation').fadeOut(3000);

  // $('.btn-create-new-project').on('click', function(e){
  //   e.preventDefault();
  //   $('.form-create-project').show();
  // });
});
