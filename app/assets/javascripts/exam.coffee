# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

day_html = (n, date) ->
  """
      <div>
        <label>Suggested Day #{n}:</label>
        <input name="date[]" type="date" value="#{date}">
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
        <br>
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
  
  $('#add_suggested_dates').click ->
    date = $('input[type=date]').first().val();
    $('#suggested_days').append(day_html(++total_days, date))