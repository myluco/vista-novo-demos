################################################################################
#
# Blood Pressures Controller
#
#   This controller defines the RESTful interface for the blood pressure 
#   resource, which operates on observation resources in VistA Novo.  Like the
#   Patient controller, the patient is implied.  
#
#   More work would be necessary to support blood pressure values for multiple 
#   patients.
#
# Copyright (c) 2014 The MITRE Corporation.  
# All rights reserved.
#
################################################################################

class BloodPressuresController < ApplicationController

  # POST /blood_pressures
  #
  # This method adds the new blood pressure value to VistA Novo.

  def create
  	@blood_pressure = BloodPressure.new(params[:blood_pressure])
    @blood_pressure.time = Time.now

  	if @blood_pressure.valid?
      save_to_vista_novo("http://localhost:3000/observation/create", 
                                fhir_for_blood_pressure)
  	else
      flash[:error] = "Sorry, something was wrong with the data you entered.  Please try again."
    end
    
    redirect_to :root
  end

  #-----------------------------------------------------------------------------
  private
  #-------------------------------------------------------------------------------

  # This routine saves the blood pressure reading to VistA Novo.

  def save_to_vista_novo(url, resource)
    HTTParty.post(url, body: resource, headers: { 'Content-Type' => 'application/json' } )
  end

  #-------------------------------------------------------------------------------

  # This routine generates the FHIR JSON for the new blood pressure reading.

  def fhir_for_blood_pressure
    { appliesDateTime: @blood_pressure.time.to_i * MILLISECONDS_PER_SECOND,
        component: [ { valueCodeableConcept: { coding: [] },
                        valueQuantity: { value: @blood_pressure[:systolic].to_s, units: "mm[Hg]" },
                        name: { coding: [ { system: "http://loinc.org", code: "8480-6" } ] } },
                      { valueCodeableConcept: { coding: [] }, 
                        valueQuantity: { value: @blood_pressure[:diastolic].to_s, units: "mm[Hg]" },
                        name: { coding: [ { system: "http://loinc.org", code: "8462-4" } ] } }
                    ],
        referenceRange: [], method: { coding: [] }, bodySite: { coding: [] }, interpretation: { coding: [] },
          valueCodeableConcept: { coding: [] },
          name: { coding: [ { system: "http://loinc.org", code: "" } ] } 
    }.to_json    
  end

end
