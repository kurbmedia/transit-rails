@Mercury.modalHandlers.insertLink = {

  initialize: ->
    @editing = false
    @content = null

    # make the inputs work with the radio buttons
    @element.find('.control-label input').on('click', @onLabelChecked)
    @element.find('.controls .optional, .controls .required').on('focus', @onInputFocused)

    @initializeForm()
    
    # build the link on form submission
    @element.find('form').on 'submit', (event) =>
      event.preventDefault()
      @validateForm()
      unless @valid
        @resize()
        return
      @submitForm()
      @hide()


  initializeForm: ->

    # get the selection and initialize its information into the form
    return unless Mercury.region && Mercury.region.selection
    selection = Mercury.region.selection()

    # set the text content
    @element.find('#link_text').val(selection.textContent()) if selection.textContent

    # if we're editing a link prefill the information

    a = selection.commonAncestor(true).closest('a') if selection && selection.commonAncestor
    img = /<img/.test(selection.htmlContent()) if selection.htmlContent
    return false unless img || a && a.length

    # don't allow changing the content on edit
    @element.find('#link_text_container').hide()

    @content = selection.htmlContent() if img

    return false unless a && a.length
    @editing = a

    @element.find('#link_external_url').val(a.attr('href'))

    # if it has a target, select it, and try to pull options out
    if a.attr('target')
      @element.find('#link_target').val(a.attr('target'))


  onLabelChecked: ->
    forInput = jQuery(@).closest('.control-label').attr('for')
    jQuery(@).closest('.control-group').find("##{forInput}").focus()


  onInputFocused: ->
    jQuery(@).closest('.control-group').find('input[type=radio]').prop('checked', true)


  addInputError: (input, message) ->
    input.after('<span class="help-inline error-message">' + Mercury.I18n(message) + '</span>').closest('.control-group').addClass('error')
    @valid = false


  clearInputErrors: ->
    @element.find('.control-group.error').removeClass('error').find('.error-message').remove()
    @valid = true


  validateForm: ->
    @clearInputErrors()

    type = @element.find('input[name=link_type]:checked').val()

    el = @element.find("#link_#{type}")
    @addInputError(el, "can't be blank") unless el.val()

    if !@editing && !@content
      el = @element.find('#link_text')
      @addInputError(el, "can't be blank") unless el.val()


  submitForm: ->
    content = @element.find('#link_text').val()
    target = @element.find('#link_target').val()
    type = @element.find('input[name=link_type]:checked').val()
    attrs = {href: @element.find("#link_#{type}").val()}
    value = {tagName: 'a', attrs: attrs, content: @content || content}

    if @editing
      Mercury.trigger('action', {action: 'replaceLink', value: value, node: @editing.get(0)})
    else
      Mercury.trigger('action', {action: 'insertLink', value: value})

}