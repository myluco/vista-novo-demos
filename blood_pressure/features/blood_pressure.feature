Feature: Tracking blood pressure
  As a patient
  I want to track my blood pressure
  So that I can be healthier

  Scenario: Get blood pressure data
    Given a set of blood pressure values
    When I go to the patient page
    Then I see a blood pressure graph

  Scenario: Add blood pressure value
    Given a set of blood pressure values
    When I enter "120" in the systolic field
      And I enter "80" in the diastolic field
      And I press "Submit"
    Then I should see that new blood pressure reading
      And the blood pressure form should be cleared
