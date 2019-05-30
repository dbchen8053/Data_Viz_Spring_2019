
var url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson"



function radius(magnitude) {
  return magnitude * 10;
}

function color(magnitude) {
  
  if (magnitude > 5) {
    return '#900000'
  }
  else if (magnitude > 4) {
    return '#ff0000'
  }
  else if (magnitude > 3) {
    return '#ff6600'
  }
  else if (magnitude > 2) {
    return '#ff9900'
  }
  else if (magnitude > 1) {
    return '#ffcc00'
  }
  else {
    return '#ffff00'
  }
}

d3.json(url, d=> {
  createFeatures(d.features);
});

function createFeatures(earthquakeData) {
  function pointToLayer(feature, latlng) {
    var marker_style = {
      stroke: true,
      weight: 1,
      fillOpacity: 0.5,
      fillColor: color(feature.properties.mag),
      color: "white",
      radius: radius(feature.properties.mag)
    };
    return new L.circleMarker(latlng, marker_style);
  }
  function onEachFeature(feature, layer) {
    layer.bindPopup("<h3>" + feature.properties.place +
      "</h3><hr><p>" + new Date(feature.properties.time) + "</p>");
  }

  var earthquakes = L.geoJSON(earthquakeData, {
    pointToLayer: pointToLayer,
    onEachFeature: onEachFeature
  });

  createMap(earthquakes);
}

function createMap(earthquakes) {

  // Define streetmap and darkmap layers
  var streetmap = L.tileLayer("https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}", {
    attribution: "Map data &copy; <a href=\"https://www.openstreetmap.org/\">OpenStreetMap</a> contributors, <a href=\"https://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>, Imagery © <a href=\"https://www.mapbox.com/\">Mapbox</a>",
    maxZoom: 18,
    id: "mapbox.streets",
    accessToken: API_KEY
  });

  // Define a baseMaps object to hold our base layers
  var baseMaps = {
    "Street Map": streetmap,
  };

  // Create overlay object to hold our overlay layer
  var overlayMaps = {
    Earthquakes: earthquakes
  };

  // Create our map, giving it the streetmap and earthquakes layers to display on load
  var myMap = L.map("map", {
    center: [
      37.09, -95.71
    ],
    zoom: 5,
    layers: [streetmap, earthquakes]
  });

  var legend = L.control({position: 'bottomright'});

  legend.onAdd = function (myMap) {
  
      var div = L.DomUtil.create('div', 'info legend'),
          grades = [0, 1, 2, 3, 4, 5],
          labels = [];
  
      // loop through our density intervals and generate a label with a colored square for each interval
      for (var i = 0; i < grades.length; i++) {
          div.innerHTML +=
              '<i style="background:' + color(grades[i] + 1) + '"></i> ' +
              grades[i] + (grades[i + 1] ? '&ndash;' + grades[i + 1] + '<br>' : '+');
      }
  
      return div;
  };
  
  legend.addTo(myMap);
  
  // Create a layer control
  // Pass in our baseMaps and overlayMaps
  // Add the layer control to the map
  L.control.layers(baseMaps, overlayMaps, {
    collapsed: false
  }).addTo(myMap);
}

