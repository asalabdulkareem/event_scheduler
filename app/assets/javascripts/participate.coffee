cycle_class = () ->
  if $(this).hasClass('not-suitable')
    $(this).removeClass('not-suitable')
  else if $(this).hasClass('suitable')
    $(this).removeClass('suitable')
    $(this).addClass('not-suitable')
  else
    $(this).addClass('suitable')

update_selected_times = () ->
  html = ''
  $('.suitable').each ->
    html += '<input type="hidden" name="suitable[]" value="' + $(this).data('time') + '">'
  $('.not-suitable').each ->
    html += '<input type="hidden" name="not_suitable[]" value="' + $(this).data('time') + '">'
  $('#selected_times').html(html)

window.participate_init = () ->
  $(document).on 'click', '.available', ->
    cycle_class.call(this)
    update_selected_times()
  
  