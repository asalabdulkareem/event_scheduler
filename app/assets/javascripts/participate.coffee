cycle_class = () ->
    if $(this).hasClass('not-suitable')
      $(this).removeClass('not-suitable')
    else if $(this).hasClass('suitable')
      $(this).removeClass('suitable')
      $(this).addClass('not-suitable')
    else
      $(this).addClass('suitable')

window.participate_init = () ->
  $(document).on 'click', '.available', cycle_class
  
  