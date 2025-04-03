Feature: Patient Treatment
  As a doctor
  I want to provide treatment to patients
  So that their health condition improves

  Background:
    Given there is a patient admitted with ID "P12345"
    And the patient has been diagnosed with "pneumonia"

  Scenario: Administering medication
    When the doctor prescribes "Antibiotics" for the patient
    Then the medication should be added to the patient's treatment plan
    And nursing staff should be notified to administer the medication
    And the patient's health status should be monitored

  Scenario: Performing surgery
    Given the patient requires "appendectomy"
    When the surgeon schedules the surgery
    Then the operating room should be reserved
    And the necessary surgical team should be assembled
    And post-operative care should be prepared

  Scenario: Lab tests and diagnostics
    When the doctor requests "blood work" and "chest X-ray"
    Then the lab should receive the test requests
    And the patient should be scheduled for the procedures
    And the results should be attached to the patient's file once available
