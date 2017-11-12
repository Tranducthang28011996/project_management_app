$(document).ready(function(){
  $('body').on('click', '.edit-profile', function() {
    $('.profile-content').css('height', '500px');
    $('.show-edit-profile').css('display', 'block');
    $('.user-infor').css('display', 'none');
  });

  $('body').on('click', '.cancel-profile', function(){
    $('.show-edit-profile').css('display', 'none');
    $('.user-infor').css('display', 'block');
    $('.profile-content').css('height', '200px');
  })
});
