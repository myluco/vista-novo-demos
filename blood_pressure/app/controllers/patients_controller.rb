################################################################################
#
# Patients Controller
#
#   This controller defines the RESTful interface for the patient resource.
#   The patient, however, is implied and currently cannot be specifically 
#   referenced.  
#
#   Additional work would be needed to support multiple patients.
#
# Copyright (c) 2014 The MITRE Corporation.  
# All rights reserved.
#
################################################################################

class PatientsController < ApplicationController

  # GET /
  #
  # This method displays the blood pressure readings for an implied patient.

  def show
    highchart_time_line(get_blood_pressures)
  	@blood_pressure = BloodPressure.new
  end

  #-----------------------------------------------------------------------------
  private
  #-----------------------------------------------------------------------------

  # This method retrieves the blood pressure observations from VistA Novo.

  def get_blood_pressures
    # Call VistA Novo
    response = call_vista_novo('http://localhost:3000/observation')
    blood_pressures = []

    # Parse blood pressure data from response into an array
    response["entry"].map do |item|
      value = Hash.new
      value[:date] = Date.parse(item["content"]["appliesDateTime"]).to_datetime.to_i * 
                              MILLISECONDS_PER_SECOND
      value[:systolic], value[:diastolic] = item["content"]["component"].map do |component|
        component["valueQuantity"]["value"].to_i
      end
      blood_pressures << value
    end

    # Sort blood pressure readings by date
    blood_pressures.sort_by { |bp| bp[:date] }
  end

  #-----------------------------------------------------------------------------

  # This method sets up the chart to display blood pressure readings over time
  # through two separate lines, one for the systolic pressure, the other for the
  # diastolic pressure.

  def highchart_time_line(blood_pressures)
    @timeline = LazyHighCharts::HighChart.new('graph') do |f|
      f.title({ :text => "Blood Pressure" })
      f.chart(defaultSeriesType: "timeseries")

      f.options[:xAxis] = { type: "datetime" }
      f.options[:xAxis][:title] = { text: "Date" }
      f.options[:legend] = { enabled: false }

      f.series(type: 'line', name: 'Systolic', 
                  data: blood_pressures.map { |bp| [ bp[:date], bp[:systolic] ] })
      f.series(type: 'line', name: 'Diastolic', 
                  data: blood_pressures.map { |bp| [ bp[:date], bp[:diastolic] ] })
    end
  end

  #-----------------------------------------------------------------------------

  # This method calls VistA Novo using the specified URL and parses the returned
  # JSON string.

  def call_vista_novo(url)
    string = HTTParty.get(url, 
                  basic_auth: { username: "andy@mitre.org", password: "splatter" })
    JSON.parse(string)
  end

end
