Feature: Emergency Scenarios
  As a hospital emergency department
  I want to handle emergency situations effectively
  So that lives can be saved in critical situations

  Background:
    Given the hospital emergency department is operational
    And emergency staff are on duty

  Scenario: Mass casualty incident
    When notification of a "bus accident with multiple casualties" is received
    Then the hospital should enter mass casualty incident mode
    And additional staff should be called in
    And elective procedures should be postponed
    And triage areas should be established

  Scenario: Critical patient arrival
    When a patient arrives with "cardiac arrest"
    Then the resuscitation team should be activated
    And the patient should be taken directly to the resuscitation area
    And vital monitoring should be established immediately
    And treatment should begin according to ACLS protocols
