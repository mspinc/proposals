$(document).ready(function() {
  $(".comment").shorten({
    "showChars": 120,
    "moreText": '<i class="align-middle me-2 fas fa-fw fa-arrow-down"></i>',
    "lessText": '<i class="align-middle me-2 fas fa-fw fa-arrow-up"></i>'
  });

  $(document).on('hide.bs.modal', '#email-preview', function(event) {
    window.location.reload()
  });
});
