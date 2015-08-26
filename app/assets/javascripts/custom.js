function initOperationsTable() {
  $('#add-operation').click(function(event) {
    event.preventDefault();
    $('#new_operation').submit();
  });
}

function refreshOperationsTable() {
  $('.remove-operation').click(function(event) {
    event.preventDefault();
    $(this).closest('form').submit();
  });

  $('.datepicker').datepicker({
    changeMonth: true,
    changeYear: true
  });

  $('.select2').select2();
}

$(document).ready(function() {
  initOperationsTable();
  refreshOperationsTable();
});
