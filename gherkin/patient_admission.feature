Feature: Patient Admission
  As a hospital administrator
  I want to admit patients into the hospital
  So that they can receive necessary medical care

  Background:
    Given the hospital system is running
    And there are available beds in the hospital

  Scenario: Regular patient admission
    When a patient arrives with symptoms of "flu"
    Then the patient should be registered in the system
    And their initial health status should be recorded
    And they should be assigned to a doctor

  Scenario: Emergency patient admission
    Given an emergency patient arrives with "severe trauma"
    When the emergency protocol is activated
    Then the patient should be immediately registered
    And assigned to the emergency department
    And a trauma team should be alerted

  Scenario: Patient admission with no available beds
    Given the hospital has no available beds
    When a patient arrives with symptoms of "pneumonia"
    Then the patient should be registered in the waiting list
    And notification should be sent to bed management
