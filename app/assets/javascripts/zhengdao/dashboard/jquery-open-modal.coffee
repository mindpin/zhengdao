jQuery.open_modal = (component, config={})->
  $dom = jQuery """
    <div class="ui modal small jquery">
      <div class="content">
      </div>
    </div>
  """
    .appendTo document.body

  a = React.render component, $dom.find('.content')[0]
  a.setState 
    $modal_dom: $dom
    close: (func)->
      console.log func
      $dom.modal 'hide', ->
        $dom.remove()
        func?()

  config = jQuery.extend({
    blurring: false
    closable: true
  }, config)

  $dom
    .modal config
    .modal('show')


jQuery.open_large_modal = (component, config={})->
  $dom = jQuery """
    <div class="ui modal">
      <div class="content">
      </div>
    </div>
  """
    .appendTo document.body

  a = React.render component, $dom.find('.content')[0]
  a.setState 
    $modal_dom: $dom
    close: (func)->
      console.log func
      $dom.modal 'hide', ->
        $dom.remove()
        func?()

  config = jQuery.extend({
    blurring: false
    closable: true
  }, config)

  $dom
    .modal config
    .modal('show')