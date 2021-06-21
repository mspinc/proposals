$(document).ready(function() {
  $(document).on('hide.bs.modal', '#email-preview', function(event) {
    window.location.reload()
  });

  var today = new Date().toISOString().split('T')[0];
  document.getElementsByName("invite[deadline_date]")[0].setAttribute('min', today);
  document.getElementsByName("invite[deadline_date]")[1].setAttribute('min', today);
});
