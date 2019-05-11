function buildMetadata(sample) {
  var metadata = d3.select("#sample-metadata");
  var url = `/metadata/${sample}`;
  d3.json(url).then(function(response) {
    // console.log(`Going to ${url}`)
    // console.log(response);
    
    Object.entries(response).forEach(function([key, value]){
      // console.log(key);
      // console.log(value);
      var row = metadata.append("tr");
      row.append("td").text(key)
      row.append("td").text(value)
      
    });
    
  })
  metadata.html("")
}
  // @TODO: Complete the following function that builds the metadata panel

  // Use `d3.json` to fetch the metadata for a sample
    // Use d3 to select the panel with id of `#sample-metadata`

    // Use `.html("") to clear any existing metadata

    // Use `Object.entries` to add each key and value pair to the panel
    // Hint: Inside the loop, you will need to use d3 to append new
    // tags for each key-value in the metadata.

    // BONUS: Build the Gauge Chart
    // buildGauge(data.WFREQ);


function buildCharts(sample) {
  var url = `/samples/${sample}`
  d3.json(url).then(function(response) {
    // console.log(response.otu_ids);
    // console.log(response.otu_labels);
    // console.log(response.sample_values);

    var trace1 = {
      x: response.otu_ids,
      y: response.sample_values,
      text: response.otu_labels,
      mode: 'markers',
      marker: {
        color: response.otu_ids,
        size: response.sample_values
      }
    };
    
    var data1 = [trace1];
    
    var layout1 = {
      title: 'Bubble Chart',
      showlegend: false,
      height: 600,
      width: 1200
    };
    
    Plotly.newPlot("bubble", data1, layout1);

    var trace2 = {
      values: response.sample_values.slice(0, 10),
      labels: response.otu_ids.slice(0, 10),
      text: response.otu_labels.slice(0, 10),
      type: "pie"

    };

    var data2 = [trace2];

    var layout2 = {
      title: 'Pie Chart',
      showlegend: response.otu_labels.slice(0, 10),
      height: 600,
      width: 600
    };
    
    Plotly.newPlot("pie", data2, layout2);

    // var otu = sort_sample_values.map(d=>d.otu_ids)
    // console.log(otu)

  })
}
  // @TODO: Use `d3.json` to fetch the sample data for the plots

    // @TODO: Build a Bubble Chart using the sample data

    // @TODO: Build a Pie Chart
    // HINT: You will need to use slice() to grab the top 10 sample_values,
    // otu_ids, and labels (10 each).


function init() {
  // Grab a reference to the dropdown select element
  var selector = d3.select("#selDataset");

  // Use the list of sample names to populate the select options
  d3.json("/names").then((sampleNames) => {
    sampleNames.forEach((sample) => {
      selector
        .append("option")
        .text(sample)
        .property("value", sample);
    });

    // Use the first sample from the list to build the initial plots
    const firstSample = sampleNames[0];
    buildCharts(firstSample);
    buildMetadata(firstSample);
  });
}

function optionChanged(newSample) {
  // Fetch new data each time a new sample is selected
  buildCharts(newSample);
  buildMetadata(newSample);
}

// Initialize the dashboard
init();
