jQuery.open_modal = (component, config={})->
  $dom = jQuery """
    <div class="ui modal">
      <div class="content">
      </div>
    </div>
  """
    .appendTo document.body

  a = React.render component, $dom.find('.content')[0]
  a.setState $modal_dom: $dom

  config = jQuery.extend({
    blurring: true
    closable: true
  }, config)

  $dom
    .modal config
    .modal('show')