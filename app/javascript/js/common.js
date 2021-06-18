$(document).ready(function() {
  $(document).on('hide.bs.modal', '#email-preview', function(event) {
    window.location.reload()
  });
});
