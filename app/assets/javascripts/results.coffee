render_selected_times = () ->
  update_times = {}
  $('.available').each -> 
    time = $(this).data('time')
    update_times[time] = {
      suitable: 0,
      not_suitable: 0
    }
  
  # aggregate times for all participants
  for participant in participants
    # skip participant
    if !participant.show
      continue
      
    for selected_time in participant.times
      time = selected_time.time
      if selected_time.suitable
        update_times[time].suitable++
      else
        update_times[time].not_suitable++
  
  # update times
  for time of update_times
    html = "<span class='num-suitable'>" + update_times[time].suitable + "</span>"
    html += "<span class='num-not-suitable'>" + update_times[time].not_suitable + "</span>"
    $('[data-time=' + time + ']').html(html)

# hide/show specific participant's selected times
window.toggle_participant = (index) ->
  participants[index].show ^= true
  render_selected_times()
  return
  

window.results_init = () ->
  num_participants = participants.length
  for i in [0..num_participants-1]
    html = '<tr><td>' + participants[i].name + '</td><td><a href="javascript:toggle_participant(' + i + ');">Hide/Show</a></td></tr>'
    $('.participants').append(html)
    render_selected_times()