# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$.rails.allowAction = (link) ->
  return true unless link.attr('data-confirm')
  $.rails.showConfirmDialog(link) # look bellow for implementations
  false # always stops the action since code runs asynchronously

$.rails.confirmed = (link) ->
  link.removeAttr('data-confirm')
  link.trigger('click.rails')

$.rails.showConfirmDialog = (link) ->
  html = """
         <div id="dialog-confirm" title="Are you sure you want to delete?">
           <p>These item will be permanently deleted and cannot be recovered. Are you sure?</p>
         </div>
         """
  $(html).dialog
    resizable: false
    modal: true
    buttons:
      OK: ->
        $.rails.confirmed link
        $(this).dialog "close"
      Cancel: ->
        $(this).dialog "close"

# better deletion confirmations!  For more info, see:
# http://www.pjmccormick.com/nicer-rails-confirm-dialogs-and-not-just-delete-methods
$.rails.showConfirmDialog = (link) ->
  message = link.attr 'data-confirm'
  html = """
          <div class="modal fade">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Confirm Deletion</h4>
                </div>
                <div class="modal-body">
                  <p>#{message}</p>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                  <button type="button" class="btn btn-primary">Delete</button>
                </div>
              </div>
            </div>
          </div>
          """
  $(html).modal()
  $('#confirmationDialog .confirm').on 'click', -> $.rails.confirmed(link)

jQuery ->
  $('.best_in_place').best_in_place()
