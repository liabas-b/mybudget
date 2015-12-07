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
    dateFormat: 'dd/mm/yy'
  });

  $('.select2').select2();
}

$(document).on('ready page:load', function(event) {
  initOperationsTable();
  refreshOperationsTable();
});

$(document).on('page:partial-load', function(event) {
  alert('partial reload')
  // apply non-idempotent transformations to the nodes in event.data
});
