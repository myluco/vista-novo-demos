################################################################################
#
# Blood Pressure Model
#
#   This model contains the information and business logic for blood pressure 
#   readings.  Instances only reside in RAM and are not stored in a database.
#
# Copyright (c) 2014 The MITRE Corporation.  
# All rights reserved.
#
################################################################################

class BloodPressure

	include ActiveAttr::Model                     # Model only resides in RAM

  attribute   :time,      type: DateTime        # Date and time of reading
  attribute   :systolic,  type: Integer         # Systolic blood pressure
  attribute   :diastolic, type: Integer         # Diastolic blood pressure

  #-----------------------------------------------------------------------------
  # Validations
  #-----------------------------------------------------------------------------

	validates_presence_of      :time
  validates_numericality_of  :systolic, :diastolic

end
