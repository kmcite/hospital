Feature: Patient Referral
  As a doctor
  I want to refer patients to other hospitals when necessary
  So that they can receive specialized care not available at our facility

  Background:
    Given there is a patient with ID "P12345" in the hospital
    And the patient requires specialized treatment not available here

  Scenario: Referral to specialist hospital
    When the doctor decides to refer the patient to "Cardiology Hospital"
    Then a referral document should be created
    And the receiving hospital should be notified
    And patient transport should be arranged
    And the patient's records should be transferred securely

  Scenario: Emergency referral
    Given the patient has a critical condition requiring immediate specialized care
    When the doctor initiates an emergency referral
    Then all nearby specialized facilities should be checked for availability
    And emergency transport should be arranged immediately
    And the patient's critical information should be sent ahead
