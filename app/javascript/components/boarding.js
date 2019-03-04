$(function() {
  $('#join-button').click(function(e) {
    e.preventDefault();
    $('#boarding-1').addClass('panel-hidden');
    $('#boarding-2').removeClass('panel-hidden');
  })
})
