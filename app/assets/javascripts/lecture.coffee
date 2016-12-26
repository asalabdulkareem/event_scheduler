# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

day_html = (n) ->
  """
      <div>
        <label>Day #{n}:</label>
        <select name="day[]">
          <option value="sunday">Sunday</option>
        <option value="monday">Monday</option>
        <option value="tuesday">Tuesday</option>
        <option value="wednesday">Wednesday</option>
        <option value="thursday">Thursday</option>
        <option value="friday">Friday</option>
        <option value="saturday">Saturday</option>
        </select>
        <br>
        <label>From</label>
        <select name="from[]">
        <option value="28800">8:00 A.M.</option>
        <option value="30600">8:30 A.M.</option>
        <option value="32400">9:00 A.M.</option>
        <option value="34200">9:30 A.M.</option>
        <option value="36000">10:00 A.M.</option>
        <option value="37800">10:30 A.M.</option>
        <option value="39600">11:00 A.M.</option>
        <option value="41400">11:30 A.M.</option>
        <option value="43200">12:00 P.M.</option>
        <option value="45000">12:30 P.M.</option>
        <option value="46800">1:00 P.M.</option>
        <option value="48600">1:30 P.M.</option>
        <option value="50400">2:00 P.M.</option>
        <option value="52200">2:30 P.M.</option>
        </select>
        <label>To</label>
        <select name="to[]">
        <option value="30600">8:30 A.M.</option>
        <option value="32400">9:00 A.M.</option>
        <option value="34200">9:30 A.M.</option>
        <option value="36000">10:00 A.M.</option>
        <option value="37800">10:30 A.M.</option>
        <option value="39600">11:00 A.M.</option>
        <option value="41400">11:30 A.M.</option>
        <option value="43200">12:00 P.M.</option>
        <option value="45000">12:30 P.M.</option>
        <option value="46800">1:00 P.M.</option>
        <option value="48600">1:30 P.M.</option>
        <option value="50400">2:00 P.M.</option>
        <option value="52200">2:30 P.M.</option>
        <option value="54000">3:00 P.M.</option>
        </select>
      </div>
  """

$ ->
  total_days = 1
  $("#event_num_times").change ->
    new_html = ''
    i = 1
    n = parseInt($(this).val())
    while i <= n
      new_html += day_html(i)
      i++
    $('#days').html(new_html)
    $('#suggested_days').html('')
    total_days = n
  
  $('#add_suggested_days').click ->
    $('#suggested_days').append(day_html(++total_days))