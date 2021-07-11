$(document).ready(function() {
  $(document).on('hide.bs.modal', '#email-preview', function(event) {
    window.location.reload()
  });

  $('[id^="chartjs"]').each(function(index, el) {
    this.style.height = '200px'
  })

  $('#add-more-participant, #add-more-organizer').click();
});
