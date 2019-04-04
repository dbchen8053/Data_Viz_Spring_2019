import numpy as np

import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func

from flask import Flask, jsonify


#################################################
# Database Setup
#################################################
engine = create_engine("sqlite:///Resources/hawaii.sqlite")

# reflect an existing database into a new model
Base = automap_base()
# reflect the tables
Base.prepare(engine, reflect=True)

# Save reference to the table
Measurement = Base.classes.measurement
Station = Base.classes.station

# Create our session (link) from Python to the DB
session = Session(engine)

#################################################
# Flask Setup
#################################################
app = Flask(__name__)
# start = "2016-01-03"
# end = "2016-01-13"
#################################################
# Flask Routes
#################################################

@app.route("/")
def welcome():
    """List all available api routes."""
    return (
        f"Available Routes:<br/>"
        f"/api/v1.0/precipitation<br/>"
        f"/api/v1.0/stations<br/>"
        f"/api/v1.0/tobs<br/>"
        f"/api/v1.0/<start><br/>"
        f"/api/v1.0/<start>/<end><br/>"
    )

@app.route("/api/v1.0/precipitation")
def precipitation():
    q_date_prcp1 = session.query(Measurement.date, func.sum(Measurement.prcp)).group_by(Measurement.date).all()
    result1 = []
    for date, prcp in q_date_prcp1:
        prcp_dict = {}
        prcp_dict["date"] = date
        prcp_dict["prcp"] = prcp
        result1.append(prcp_dict)

    return jsonify(result1)

@app.route("/api/v1.0/stations")
def stations():
    q_station_active = session.query(Measurement.station).group_by(Measurement.station).all()
    result2 =[]
    for station in q_station_active:
        result2.append(station)
    return jsonify(result2)

@app.route("/api/v1.0/tobs")
def tobs():
    q_station_temp = session.query(Measurement.tobs).filter(Measurement.station == "USC00519281").filter(Measurement.date <= "2017-08-23", Measurement.date >= "2016-08-23").all()
    result3 =[]
    for temp in q_station_temp:
        result3.append(temp)
    return jsonify(result3)

@app.route("/api/v1.0/<start>")
def calc_temps(start):
    start_temp = session.query(func.min(Measurement.tobs), func.avg(Measurement.tobs), func.max(Measurement.tobs)).filter(Measurement.date >= start).all()
    result4 = []
    for mintemp, avgtemp, maxtemp in start_temp:
        start_dict = {}
        start_dict["min temp"] = mintemp
        start_dict["avg temp"] = avgtemp
        start_dict["max temp"] = maxtemp
        result4.append(start_dict)        
    return jsonify(result4)

@app.route("/api/v1.0/<start>/<end>")
def calc_temps2(start, end):
    start_end_temp = session.query(func.min(Measurement.tobs), func.avg(Measurement.tobs), func.max(Measurement.tobs)).filter(Measurement.date >= start, Measurement.date <= end).all()
    result5 = []
    for mintemp, avgtemp, maxtemp in start_end_temp:
        start_end_dict = {}
        start_end_dict["min temp"] = mintemp
        start_end_dict["avg temp"] = avgtemp
        start_end_dict["max temp"] = maxtemp
        result5.append(start_end_dict)        
    return jsonify(result5)

if __name__ == '__main__':
    app.run(debug=True)