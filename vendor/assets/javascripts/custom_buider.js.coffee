class RichMarkerBuilder extends Gmaps.Google.Builders.Marker #inherit from builtin builder
  #override create_marker method
  #create_marker: ->
  #  options = _.extend @marker_options(), @rich_marker_options()
  #  @serviceObject = new RichMarker options #assign marker to @serviceObject

  #rich_marker_options: ->
  #  marker = document.createElement("div")
  #  marker.setAttribute 'class', 'marker_container'
  #  marker.innerHTML = '<p>' + @args.address + '/<p>'
  #  { content: marker }

  create_infowindow: ->
    return null unless _.isString @args.address

    boxText = document.createElement("div")
    boxText.setAttribute('class', 'marker_container') #to customize
    boxText.innerHTML = '<p>' + @args.address + '/<p>'
    @infowindow = new InfoBox(@infobox(boxText))

    # add @bind_infowindow() for < 2.1

  infobox: (boxText)->
    content: boxText
    pixelOffset: new google.maps.Size(-140, 0)
    boxStyle:
      width: "280px"

@buildMap = (markers)->
  handler = Gmaps.build 'Google', { builders: { Marker: RichMarkerBuilder} }

  #then standard use
  handler.buildMap { provider: {}, internal: {id: 'map'} }, ->
    markers = handler.addMarkers(markers)
    handler.bounds.extendWith(markers)
    handler.fitMapToBounds()
    handler.getMap().setZoom(16)
