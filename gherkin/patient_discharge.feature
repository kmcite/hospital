Feature: Patient Discharge
  As a hospital administrator
  I want to discharge patients when they're ready
  So that hospital resources can be efficiently utilized

  Background:
    Given a patient with ID "P12345" has been treated
    And their health status is "recovered"

  Scenario: Regular discharge
    When the doctor approves the discharge
    Then the patient should be removed from the active patients list
    And a discharge summary should be generated
    And the bed should be marked as available after cleaning

  Scenario: Discharge with follow-up care
    When the doctor approves the discharge with follow-up requirements
    Then the patient should be scheduled for follow-up appointments
    And instructions for home care should be provided
    And the patient should be discharged from the hospital

  Scenario: Discharge against medical advice
    When the patient requests discharge against medical advice
    Then the patient should sign an acknowledgment form
    And the doctor should document the risks explained to the patient
    And the patient should be discharged with a note of "against medical advice"
