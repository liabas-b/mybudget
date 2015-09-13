function initOperationsTable() {
  // $('#add-operation').click(function(event) {
  //   event.preventDefault();
  //   $('#new_operation').submit();
  // });
}

function refreshOperationsTable() {
  $('[data-toggle="popover"]').popover({html: true});

  $('[data-toggle="popover"]').unbind('click').click(function(event) {
    $(this).popover('toggle');
    refreshOperationsTable();
  });

  $('.remove-operation').unbind('click').click(function(event) {
    event.preventDefault();
    $(this).closest('form').submit();
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
  $('.edit_account').focusout(function() {
    $(this).submit();
  });
}

$(document).on('ready page:load', function(event) {
  initOperationsTable();
  refreshOperationsTable();
  initAccountForm();
});

$(document).on('page:partial-load', function(event) {
  alert('partial reload')
  // apply non-idempotent transformations to the nodes in event.data
});
