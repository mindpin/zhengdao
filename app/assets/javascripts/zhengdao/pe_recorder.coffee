@PeRecorder = React.createClass
  render: ->
    define_labels = []
    for item in @props.data.define.data
      define_labels.push item.label

    for label, values of @props.data.record
      if define_labels.indexOf(label) == -1
        @props.data.define.data.push
          label: label
          values: values

    <div className='ui segment'>
    {
      for item in @props.data.define.data
        <PeRecorder.PeItemInput key={item.label} data={item} pe={@props.data} />
    }
    <a className='ui button green' href='javascript:;' onClick={@add_field}>
      <i className='icon add' />
      增加
    </a>
    </div>

  add_field: ->
    @props.data.define.data.push
      label: "新增"
      values: []
      disabled: false
    @setState {}

  get_values: ->
    result = {}
    for item in @props.data.define.data
      result[item.label] = @props.data.record[item.label] || []
    result

  statics:
    PeItemInput: React.createClass
      componentDidMount: ->
        $self = jQuery React.findDOMNode @
        $self.find('.ui.dropdown').dropdown
          allowAdditions: true
          onAdd: (addedValue, addedText, $addedChoice)=>
            @props.pe.record[@props.data.label] ||= []
            @props.pe.record[@props.data.label].push addedValue
          onRemove: (removedValue, removedText, $removedChoice)=>
            @props.pe.record[@props.data.label] ||= []
            @props.pe.record[@props.data.label] = @props.pe.record[@props.data.label].filter (value)->
              value != removedValue
      render: ->
        <div className='field'>
          <div className="ui input">
            <input type="text" name={@props.data.label} value={@props.data.label} disabled={@props.data.disabled == undefined} onChange={@on_lable_change}/>
          </div>
          <div className="ui selection search multiple dropdown">
            {
              default_values = @props.pe.record[@props.data.label]
              if default_values
                str = default_values.join(",")
                <input type="hidden" name={@props.data.label} value={str} />
              else
                <input type="hidden" name={@props.data.label} />
            }
            <i className="dropdown icon"></i>
            <div className="default text"></div>
            <div className="menu">
              {
                for value in @props.data.values
                  <div className="item" data-value={value}>{value}</div>
              }
            </div>
          </div>
        </div>

      on_lable_change: (evt)->
        values = @props.pe.record[@props.data.label]
        @props.pe.record[evt.target.value] = values
        delete @props.pe.record[@props.data.label]
        @props.data.label = evt.target.value
        @setState {}
