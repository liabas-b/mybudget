function initOperationsTable() {
  $('[data-toggle="popover"]').popover({html: true});

  $('[data-toggle="popover"]').unbind('click').click(function(event) {
    $(this).popover('toggle');
    refreshOperationsTable();
  });

  $('.datepicker').datepicker({
    changeMonth: true,
    changeYear: true,
    minDate: 0,
    dateFormat: 'dd/mm/yy'
  });

  $('.select2').select2();
}

function initAccountForm() {
  var savedSold = $('#account_sold').val();
  var savedName = $('#account_name').val();
  $('.edit_account').focusin(function() {
    $('#account-form-status').removeClass('success').addClass('warning');
  });
  $('.edit_account').focusout(function() {
    if (savedSold !== $('#account_sold').val() || savedName !== $('#account_name').val())
      $(this).submit();
    else
      $('#account-form-status').removeClass('warning').addClass('success');
  });
}

$(document).on('ready page:load', function(event) {
  initOperationsTable();
  initAccountForm();
});

$(document).on('page:partial-load', function(event) {
  alert('partial reload')
  // apply non-idempotent transformations to the nodes in event.data
});
