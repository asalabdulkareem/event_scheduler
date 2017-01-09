window.results_init = () ->
  num_participants = participants.length
  for i in [0..num_participants-1]
    html = '<tr><td>' + participants[i].name + '</td><td><a href="javascript:toggle_participant(' + i + ')">Hide/Show</a></td></tr>';
    $('.participants').append(html);

