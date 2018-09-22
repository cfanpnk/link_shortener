# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("#create_link").on("ajax:error", (e, data, status, xhr) ->
    $("#create_link").render_form_errors('link', data.responseJSON)
  )

$.fn.render_form_errors = (model_name, errors) ->
  form = this
  this.clear_form_errors()

  $.each(errors, (field, messages) ->
    input = form.find('input, select, textarea').filter(->
      name = $(this).attr('name')
      if name
        name.match(new RegExp(model_name + '\\[' + field + '\\(?'))
    )
    input.attr('id', 'has-error');
    input.parent().append('<span class="help-block">' + $.map(messages, (m) -> m.charAt(0).toUpperCase() + m.slice(1)).join('<br />') + '</span>')
  )

$.fn.clear_form_errors = () ->
  this.find('#has-error').removeAttr('id')
  this.find('span.help-block').remove()

$.fn.clear_form_fields = () ->
  this.find(':input','#myform')
      .not(':button, :submit, :reset, :hidden')
      .val('')
      .removeAttr('checked')
      .removeAttr('selected')

