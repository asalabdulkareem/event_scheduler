$ ->
  $('input[type=date]').each ->
    if(this.type != 'date')
      $(this).datepicker()