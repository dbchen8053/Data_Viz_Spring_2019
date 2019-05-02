// from data.js
var tableData = data;
var tbody = d3.select("#ufo-table");



tableData.forEach(function(d) {
    var row = tbody.append("tr");
    Object.entries(d).forEach(function([key, value]){
    var cell = tbody.append("td");
    cell.text(value);
    });
});

var submit = d3.select("#filter-btn");

submit.on("click", function(){
    d3.event.preventDefault();
    var inputElement = d3.select("#datetime");
    var inputValue = inputElement.property("value");
    tbody.html("");
    var filterData = tableData.filter(d=> d.datetime === inputValue);
    filterData.forEach(function(d) {
        var row = tbody.append("tr");
        Object.entries(d).forEach(function([key, value]){
        var cell = tbody.append("td");
        cell.text(value);
        });
    });
})






