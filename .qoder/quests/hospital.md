# Private Hospital Management Game Design

## Overview

The Private Hospital Management Game is a completely fictional offline Flutter-based mobile simulation where players manage a virtual hospital. All characters, events, and scenarios are entirely fictional with no connection to real-world healthcare data, regulations, or personalities. Any resemblance to real-life situations is purely coincidental.

### Game Domain
This is a **Business Management Simulation Game** featuring:
- Virtual hospital ownership and strategic decision-making
- Fictional staff hiring, duty assignment, and comprehensive benefits management
- Simulated penalty systems for malpractice and regulatory violations
- Complete salary structure with benefits, bonuses, and retirement planning
- Department-specific staff allocation (OPD vs Emergency)
- Performance-based rewards and legal consequences system

### Core Gameplay Challenge
Players must successfully manage a fictional private hospital while balancing multiple objectives: maintaining staff satisfaction through competitive compensation packages, avoiding legal penalties through proper staff training and duty allocation, ensuring department-specific expertise, and building long-term employee loyalty through retirement benefits and career development.

## Game Architecture

The game follows Flutter's official architecture recommendations with clean separation between presentation, domain, and data layers, optimized for offline gameplay.

```mermaid
graph TB
    subgraph "Presentation Layer"
        F[Features/Views] --> B[BLoCs]
    end
    
    subgraph "Domain Layer"
        B --> R[Repositories]
        R --> M[Models/Entities]
    end
    
    subgraph "Data Layer"
        R --> S[Services]
        S --> DB[(ObjectBox Database)]
        S --> LS[Local Storage]
    end
    
    subgraph "Game Infrastructure"
        GT[Game Timer System]
        RNG[Random Event Generator]
        AN[Achievement & Notification System]
    end
```

### Architectural Principles
- **Repository Pattern**: Each domain model has dedicated repository for CRUD operations
- **Reactive Interface**: Repositories provide observable streams for real-time game updates
- **Single Model Responsibility**: Each repository manages only one entity type
- **Offline-First Design**: All game data stored locally using ObjectBox
- **Composable Features**: UI components reusable across different game screens
- **Event-Driven Updates**: Game events trigger automatic state synchronization

## Game Domain Models

### Hospital Business Management

| Entity | Key Attributes | Business Rules |
|--------|---------------|----------------|
| **Hospital** | name, reputation, totalFunds, dailyExpenses, legalComplianceScore, penaltyHistory | Legal violations result in fines and reputation damage |
| **Department** | name, type (OPD/Emergency), requiredStaffCount, assignedStaff, operatingHours | Must maintain minimum qualified staff ratios |
| **LegalPenalty** | amount, reason, date, severity, complianceRequirement | Accumulated penalties affect hospital license status |

### Staff Management & Compensation

| Entity | Key Attributes | Business Rules |
|--------|---------------|----------------|
| **Staff** | name, assignedDepartment, dutyStatus, baseSalary, totalCompensation, hireDate | Must be assigned to specific department duties |
| **SalaryStructure** | basePay, performanceBonus, departmentAllowance, overtimeRate, benefits | Department-specific pay scales and allowances |
| **EmployeeBenefits** | healthInsurance, paidLeave, retirementContribution, bonusEligibility | Comprehensive benefits package affects retention |
| **RetirementPlan** | contributionPercent, vestingPeriod, currentBalance, withdrawalEligibility | Long-term employee financial security |

### Department Duty Assignment

| Entity | Key Attributes | Business Rules |
|--------|---------------|----------------|
| **DutyAssignment** | staffId, departmentType, shiftType, specialtyRequired, isActive | Staff can only work in assigned departments |
| **PerformanceRecord** | staffId, treatmentOutcome, patientSatisfaction, complianceScore | Poor performance triggers penalties |
| **MalpracticePenalty** | staffId, incidentType, penaltyAmount, suspensionDays, trainingRequired | Wrong treatment decisions have consequences |

### Patient Care & Treatment Outcomes

| Entity | Key Attributes | Business Rules |
|--------|---------------|----------------|
| **Patient** | name, economicStatus, condition, assignedDepartment, treatmentOutcome | Fictional patients with simulated conditions |
| **Treatment** | type, complexity, requiredSpecialty, successRate, riskLevel | Outcome depends on staff competency and assignment |
| **TreatmentOutcome** | success, complications, patientSatisfaction, legalCompliance | Failed treatments may result in legal action |

## Game Mechanics & Business Logic

### Staff Duty Assignment System

```mermaid
stateDiagram-v2
    state "Staff Management" as SM {
        [*] --> Unassigned
        Unassigned --> OPDAssigned : assignToOPD()
        Unassigned --> EmergencyAssigned : assignToEmergency()
        OPDAssigned --> OnDutyOPD : startShift()
        EmergencyAssigned --> OnDutyEmergency : startShift()
        OnDutyOPD --> PerformingTreatment : treatPatient()
        OnDutyEmergency --> PerformingTreatment : treatPatient()
        PerformingTreatment --> PenaltyAssessment : treatmentComplete()
        PenaltyAssessment --> OnDutyOPD : noIssues()
        PenaltyAssessment --> OnDutyEmergency : noIssues()
        PenaltyAssessment --> Suspended : malpractice()
        Suspended --> RetrainingRequired : servePenalty()
        RetrainingRequired --> Unassigned : completeRetraining()
    }
```

### Penalty and Legal Compliance System

```mermaid
flowchart TD
    A[Treatment Decision Made] --> B{Appropriate for Department?}
    B -->|No| C[Department Mismatch Penalty]
    B -->|Yes| D{Staff Qualified?}
    
    D -->|No| E[Unqualified Staff Penalty]
    D -->|Yes| F{Treatment Executed Correctly?}
    
    F -->|No| G[Medical Malpractice Penalty]
    F -->|Yes| H[Successful Treatment]
    
    C --> I[Staff Suspension + Fine]
    E --> J[Staff Retraining + Fine]
    G --> K[Legal Action + Heavy Fine]
    
    I --> L[Hospital Reputation Damage]
    J --> L
    K --> M[License Review + Major Reputation Loss]
    
    H --> N[Positive Outcome + Staff Bonus]
```

### Comprehensive Salary and Benefits System

```mermaid
stateDiagram-v2
    [*] --> NewEmployee
    NewEmployee --> ProbationPeriod : hire()
    ProbationPeriod --> FullEmployee : confirmEmployment()
    FullEmployee --> SeniorEmployee : promotion()
    SeniorEmployee --> RetirementEligible : yearsOfService >= 25
    
    FullEmployee --> BenefitsEligible : 6MonthsService
    SeniorEmployee --> MaxBenefits : seniorityBonus
    RetirementEligible --> Retired : chooseRetirement()
    
    BenefitsEligible --> PensionVested : 5YearsService
    MaxBenefits --> PensionVested
    PensionVested --> Retired
```

## Game Features Architecture

### Hospital Owner Dashboard
- **Financial Overview**: Real-time revenue, expenses, profit/loss, penalty costs tracking
- **Legal Compliance Monitor**: Current compliance score, pending penalties, license status
- **Department Staffing Panel**: Real-time view of staff assignments and duty status
- **Staff Performance Metrics**: Individual and department-wide performance tracking
- **Penalty Management System**: History of violations, current suspensions, compliance actions

### Advanced Staff Management System

#### Comprehensive Hiring and Assignment
- **Department-Specific Recruitment**: Hire staff with qualifications for OPD or Emergency duties
- **Duty Assignment Interface**: Explicitly assign staff to specific departments and shifts
- **Qualification Verification**: Ensure staff have required certifications for assigned duties
- **Cross-Training Programs**: Train existing staff for additional department responsibilities
- **Performance-Based Promotions**: Career advancement based on treatment success rates

#### Salary and Benefits Administration
- **Base Salary Structure**: Department-specific pay scales with experience multipliers
- **Performance Bonuses**: Monthly bonuses based on successful treatments and patient satisfaction
- **Department Allowances**: Additional compensation for high-risk Emergency assignments
- **Overtime Management**: Time-and-a-half pay for extended shifts and emergency coverage
- **Annual Salary Reviews**: Automatic salary adjustments based on performance and tenure

#### Employee Benefits Package
- **Health Insurance**: Comprehensive medical coverage affecting staff satisfaction and retention
- **Paid Time Off**: Vacation days, sick leave, and personal time allocation
- **Professional Development**: Training budget for skill enhancement and certification maintenance
- **Life Insurance**: Coverage amounts based on salary level and years of service
- **Disability Benefits**: Short-term and long-term disability coverage for work-related injuries

#### Retirement and Long-term Benefits
- **Pension Plan**: Employer-contributed retirement fund with vesting schedules
- **401k Matching**: Hospital matching contributions up to specified percentages
- **Retirement Eligibility**: Years of service and age requirements for full benefits
- **Early Retirement Options**: Reduced benefits for early retirement with penalty calculations
- **Pension Withdrawal**: Lump sum vs. annuity options upon retirement

### Department Operations Management

#### OPD (Outpatient Department)
- **Scheduled Operations**: Morning hours with pre-assigned qualified staff
- **Appointment System**: Patient scheduling with staff availability verification
- **Revenue Optimization**: Maximize billable hours while maintaining quality care
- **Staff Specialization**: Match patient conditions with appropriate specialist assignments

#### Emergency Department
- **24/7 Staffing Requirements**: Maintain minimum qualified staff at all times
- **Critical Care Protocols**: Specialized procedures requiring emergency-trained personnel
- **Triage Management**: Priority-based patient flow with appropriate staff assignment
- **Emergency Response Teams**: Coordinated staff groups for critical situations

### Legal Compliance and Penalty System

#### Violation Tracking
- **Malpractice Incidents**: Document wrong treatment decisions and their consequences
- **Staffing Violations**: Penalties for unqualified staff performing inappropriate duties
- **Department Compliance**: Ensure proper staff ratios and qualification requirements
- **License Monitoring**: Track hospital license status and compliance requirements

#### Penalty Management
- **Financial Penalties**: Automatic fine calculations based on violation severity
- **Staff Suspensions**: Temporary removal of staff from duties pending retraining
- **Mandatory Retraining**: Required education programs for staff with performance issues
- **Progressive Discipline**: Escalating consequences for repeat violations
- **License Revocation Risk**: Ultimate consequence for severe or repeated compliance failures

## Game State Management Strategy

### Repository-Based Game State
Each game domain uses dedicated repositories providing reactive streams for real-time updates:

```mermaid
graph TD
    V[Game View] --> B[Game BLoC]
    B --> HR[Hospital Repository]
    B --> SR[Staff Repository]
    B --> PR[Patient Repository]
    B --> FR[Financial Repository]
    
    HR --> HS[Hospital Service]
    SR --> SS[Staff Service]
    PR --> PS[Patient Service]
    FR --> FS[Financial Service]
    
    HS --> DB[(ObjectBox Database)]
    SS --> DB
    PS --> DB
    FS --> DB
    
    DB -.-> RS[Reactive Streams]
    RS -.-> B
```

### Game Event System
1. **Player Actions**: View → BLoC → Repository → Service → Database
2. **Automatic Updates**: Timer Events → Game Logic → Repository → Reactive Stream → BLoC → View
3. **Random Events**: Random Generator → Event Handler → Multiple Repositories → UI Updates

### Offline Game Loop
- **Real-time Simulation**: Continuous patient generation and department operations
- **Persistent State**: All game progress saved locally using ObjectBox
- **Background Processing**: Game continues when app is minimized
- **Auto-save System**: Regular state persistence to prevent data loss

## Game Actions Flow

### Hospital Owner Actions Flow

#### Staff Management Actions

```mermaid
flowchart TD
    A[Hospital Owner Dashboard] --> B{Staff Management Action}
    
    B -->|Hire Staff| C[Browse Available Candidates]
    C --> D[Review Qualifications & Salary]
    D --> E{Accept Candidate?}
    E -->|Yes| F[Create Employment Contract]
    E -->|No| C
    F --> G[Assign Department & Duties]
    G --> H[Set Salary & Benefits Package]
    H --> I[Staff Successfully Hired]
    
    B -->|Manage Existing Staff| J[View Staff List]
    J --> K{Select Action}
    K -->|Reassign Department| L[Choose New Department]
    K -->|Adjust Salary| M[Modify Compensation]
    K -->|Performance Review| N[Evaluate Staff Performance]
    K -->|Terminate Employment| O[Fire Staff with Severance]
    
    L --> P[Update Duty Assignment]
    M --> Q[Recalculate Total Compensation]
    N --> R[Update Performance Record]
    O --> S[Process Termination Benefits]
    
    I --> T[Update Hospital State]
    P --> T
    Q --> T
    R --> T
    S --> T
```

#### Department Operations Actions

```mermaid
flowchart TD
    A[Department Management] --> B{Department Type}
    
    B -->|OPD Management| C[Configure Operating Hours]
    C --> D[Assign Qualified Staff]
    D --> E[Set Appointment Schedules]
    E --> F[Monitor Patient Queue]
    F --> G{Patient Treatment Decision}
    G -->|Approve Treatment| H[Assign Appropriate Staff]
    G -->|Defer Treatment| I[Schedule Future Appointment]
    H --> J[Execute Treatment Protocol]
    J --> K[Collect Payment]
    K --> L[Update Revenue Records]
    
    B -->|Emergency Management| M[Ensure 24/7 Staffing]
    M --> N[Monitor Emergency Queue]
    N --> O{Triage Assessment}
    O -->|Life Threatening| P[Immediate Free Treatment]
    O -->|Non-Critical| Q{Payment Verification}
    Q -->|Can Pay| R[Paid Emergency Treatment]
    Q -->|Cannot Pay| S[Basic Stabilization Only]
    P --> T[Claim Government Reimbursement]
    R --> U[Collect Emergency Fees]
    S --> V[Social Responsibility Record]
    
    L --> W[Update Hospital Finances]
    T --> W
    U --> W
    V --> W
```

#### Financial Management Actions

```mermaid
flowchart TD
    A[Financial Dashboard] --> B{Financial Action}
    
    B -->|Process Payroll| C[Calculate Staff Salaries]
    C --> D[Include Performance Bonuses]
    D --> E[Add Department Allowances]
    E --> F[Calculate Overtime Pay]
    F --> G[Deduct Benefits Contributions]
    G --> H[Process Retirement Contributions]
    H --> I[Execute Payroll Payment]
    I --> J[Update Staff Financial Records]
    
    B -->|Manage Penalties| K[Review Compliance Violations]
    K --> L{Penalty Type}
    L -->|Staff Malpractice| M[Suspend Staff Member]
    L -->|Department Violation| N[Pay Regulatory Fine]
    L -->|License Issue| O[Address Compliance Requirements]
    M --> P[Require Retraining]
    N --> Q[Update Compliance Score]
    O --> R[Submit Corrective Action Plan]
    
    B -->|Investment Decisions| S[Review Available Investments]
    S --> T[Allocate Hospital Funds]
    T --> U[Monitor Investment Returns]
    U --> V[Reinvest or Withdraw]
    
    J --> W[Update Hospital Financial State]
    P --> W
    Q --> W
    R --> W
    V --> W
```

### System-Driven Actions Flow

#### Automated Game Events

```mermaid
flowchart TD
    A[Game Timer System] --> B{Scheduled Event}
    
    B -->|Patient Generation| C[Create Random Patient]
    C --> D[Assign Economic Status]
    D --> E[Generate Medical Condition]
    E --> F[Determine Urgency Level]
    F --> G[Route to Appropriate Department]
    G --> H[Add to Department Queue]
    
    B -->|Staff Performance| I[Assess Staff Energy Levels]
    I --> J{Energy Status}
    J -->|Low Energy| K[Reduce Work Efficiency]
    J -->|Normal Energy| L[Maintain Performance]
    J -->|High Energy| M[Boost Performance]
    K --> N[Update Staff Status]
    L --> N
    M --> N
    
    B -->|Compliance Audit| O[Random Compliance Check]
    O --> P[Assess Department Staffing]
    P --> Q[Review Treatment Decisions]
    Q --> R{Violations Found?}
    R -->|Yes| S[Generate Penalty]
    R -->|No| T[Improve Compliance Score]
    S --> U[Apply Financial Penalty]
    T --> V[Update Hospital Reputation]
    
    B -->|Financial Cycles| W[Process Daily Expenses]
    W --> X[Calculate Staff Costs]
    X --> Y[Update Equipment Maintenance]
    Y --> Z[Apply Utility Costs]
    Z --> AA[Update Hospital Balance]
    
    H --> BB[Trigger UI Updates]
    N --> BB
    U --> BB
    V --> BB
    AA --> BB
```

#### Patient Treatment Flow

```mermaid
stateDiagram-v2
    [*] --> PatientArrival
    PatientArrival --> DepartmentTriage : assignDepartment()
    
    DepartmentTriage --> OPDQueue : isOPDPatient()
    DepartmentTriage --> EmergencyTriage : isEmergencyPatient()
    
    OPDQueue --> PaymentVerification : nextInQueue()
    PaymentVerification --> TreatmentAssignment : paymentConfirmed()
    PaymentVerification --> TurnedAway : cannotPay()
    
    EmergencyTriage --> LifeSavingTreatment : isLifeThreatening()
    EmergencyTriage --> EmergencyPaymentCheck : isNonCritical()
    
    EmergencyPaymentCheck --> PaidEmergencyTreatment : canPay()
    EmergencyPaymentCheck --> BasicStabilization : cannotPay()
    
    TreatmentAssignment --> StaffAssignment : findQualifiedStaff()
    LifeSavingTreatment --> StaffAssignment
    PaidEmergencyTreatment --> StaffAssignment
    BasicStabilization --> StaffAssignment
    
    StaffAssignment --> TreatmentExecution : staffAvailable()
    StaffAssignment --> WaitingForStaff : noStaffAvailable()
    
    WaitingForStaff --> TreatmentExecution : staffBecomesAvailable()
    
    TreatmentExecution --> TreatmentOutcome : treatmentComplete()
    TreatmentOutcome --> SuccessfulTreatment : treatmentSuccessful()
    TreatmentOutcome --> TreatmentComplication : treatmentFailed()
    
    SuccessfulTreatment --> PaymentCollection : isPaidService()
    SuccessfulTreatment --> GovernmentClaim : isFreeService()
    TreatmentComplication --> PenaltyAssessment : assessMalpractice()
    
    PaymentCollection --> PatientDischarge
    GovernmentClaim --> PatientDischarge
    PenaltyAssessment --> PatientDischarge
    TurnedAway --> [*]
    PatientDischarge --> [*]
```

### User Interface Actions Flow

#### Navigation and Screen Flow

```mermaid
flowchart TD
    A[Game Launch] --> B[Hospital Owner Dashboard]
    
    B --> C{Main Navigation}
    C -->|Staff Management| D[Staff Management Screen]
    C -->|Department Operations| E[Department Management Screen]
    C -->|Financial Overview| F[Financial Dashboard]
    C -->|Compliance Monitor| G[Legal Compliance Screen]
    C -->|Settings & Configuration| H[Game Settings Screen]
    
    D --> I{Staff Actions}
    I -->|Hire New Staff| J[Staff Recruitment Screen]
    I -->|Manage Existing| K[Staff Details Screen]
    I -->|Performance Review| L[Staff Performance Screen]
    I -->|Payroll Management| M[Payroll Processing Screen]
    
    E --> N{Department Actions}
    N -->|OPD Management| O[OPD Operations Screen]
    N -->|Emergency Management| P[Emergency Department Screen]
    N -->|Patient Queue| Q[Patient Management Screen]
    
    F --> R{Financial Actions}
    R -->|Revenue Analysis| S[Revenue Reports Screen]
    R -->|Expense Tracking| T[Expense Management Screen]
    R -->|Investment Portfolio| U[Investment Management Screen]
    R -->|Penalty Management| V[Penalty Tracking Screen]
    
    G --> W{Compliance Actions}
    W -->|Violation History| X[Violation Records Screen]
    W -->|Staff Training| Y[Training Management Screen]
    W -->|License Status| Z[License Monitoring Screen]
    
    J --> AA[Return to Staff Management]
    K --> AA
    L --> AA
    M --> AA
    O --> BB[Return to Department Management]
    P --> BB
    Q --> BB
    S --> CC[Return to Financial Dashboard]
    T --> CC
    U --> CC
    V --> CC
    X --> DD[Return to Compliance Monitor]
    Y --> DD
    Z --> DD
    
    AA --> B
    BB --> B
    CC --> B
    DD --> B
    H --> B
```

## Offline Game Architecture

### Local Data Persistence (ObjectBox)
- **Complete Fictional Game State**: All virtual hospital data, simulated staff records, generated patient scenarios
- **Salary and Benefits Tracking**: Complete compensation history, benefits enrollment, retirement contributions
- **Legal Compliance Records**: Penalty history, compliance scores, violation tracking
- **Department Assignment History**: Staff duty assignments, performance in specific departments
- **Auto-Generated Content**: Periodic creation of fictional patients, staff candidates, and random compliance events

### Game Services Layer
- **Staff Management Service**: Hiring/firing, duty assignments, salary calculations, benefits administration
- **Payroll Service**: Automated salary processing, overtime calculations, benefits deductions, retirement contributions
- **Compliance Service**: Legal violation tracking, penalty calculations, license status monitoring
- **Performance Service**: Staff evaluation, treatment outcome tracking, departmental efficiency metrics
- **Penalty Service**: Fine calculations, suspension management, retraining requirements

### Game Timer & Simulation Engine
- **Payroll Cycles**: Automated bi-weekly or monthly salary payments with deductions
- **Performance Reviews**: Quarterly staff evaluations affecting salary and benefits
- **Compliance Audits**: Random legal inspections with potential penalty outcomes
- **Retirement Processing**: Automatic pension contributions and vesting calculations
- **Benefits Enrollment**: Annual open enrollment periods for staff benefit selections

## Game Testing Strategy

### Fictional Game Content Testing
- **Content Verification**: Ensure all data is completely fictional with no real-world connections
- **Character Generation**: Test random generation of fictional staff and patient names/profiles
- **Scenario Simulation**: Validate that all medical scenarios are clearly fictional and educational
- **Legal Disclaimer Integration**: Verify prominent display of fictional content disclaimers

### Penalty System Testing
- **Violation Detection**: Test automatic detection of staff misassignment and treatment errors
- **Penalty Calculation**: Validate fine amounts, suspension durations, and compliance scoring
- **Progressive Discipline**: Ensure escalating consequences for repeat violations
- **Legal Compliance Scoring**: Test license risk calculations and compliance recovery mechanisms

### Salary and Benefits Testing
- **Payroll Calculations**: Validate base salary, bonuses, overtime, and deduction calculations
- **Benefits Administration**: Test enrollment, eligibility, and cost calculations for all benefit types
- **Retirement Planning**: Verify pension contributions, vesting schedules, and withdrawal calculations
- **Performance-Based Compensation**: Test bonus calculations based on treatment outcomes and efficiency

### Department Assignment Testing
- **Staff Qualification Matching**: Ensure only qualified staff can be assigned to specific departments
- **Duty Rotation**: Test shift assignments and department transfer functionality
- **Performance Tracking**: Validate department-specific performance metrics and comparisons
- **Compliance Monitoring**: Test detection of unqualified staff performing inappropriate duties

## Game Performance & Scalability

### Offline Performance Optimization
- **Efficient Game Loop**: Optimized timer-based operations for continuous simulation
- **Smart Caching**: Frequently accessed game data cached in memory for smooth gameplay
- **Background Processing**: Non-critical operations (analytics, cleanup) performed asynchronously
- **Resource Management**: Automatic cleanup of old patient records and completed transactions

### Scalability Considerations
- **Progressive Complexity**: Game difficulty scales with player progress and hospital size
- **Dynamic Content**: Patient types and scenarios expand as hospital reputation grows
- **Modular Features**: New departments and specializations can be added without core changes
- **Save File Optimization**: Compressed game state storage for long-term play sessions

### Real-time Game Updates
- **Reactive UI**: Immediate visual feedback for all player actions and automatic events
- **Event Broadcasting**: Efficient propagation of game state changes to all relevant UI components
- **Memory Management**: Proper disposal of streams and listeners to prevent memory leaks
- **Performance Monitoring**: Built-in metrics for game loop performance and user experience

## Game Security & Data Management

### Fictional Content Protection
- **Content Validation**: Automated checks to ensure no real-world healthcare data is referenced
- **Random Generation**: All names, scenarios, and events generated using fictional data sources
- **Disclaimer Integration**: Prominent disclaimers about fictional nature throughout the game
- **Save Game Integrity**: Prevention of save file manipulation affecting game balance

### Game Balance Security
- **Financial Transaction Validation**: Prevent unrealistic salary manipulation or penalty avoidance
- **Staff Assignment Rules**: Enforce qualification requirements and prevent inappropriate duty assignments
- **Performance Metrics Integrity**: Validate treatment outcomes and staff performance calculations
- **Penalty System Enforcement**: Ensure legal consequences cannot be bypassed through game manipulation

### Educational Gaming Framework
- **Realistic Consequences**: Game mechanics reflect real-world business and legal principles
- **Learning Objectives**: Teach hospital management, HR practices, and compliance importance
- **Ethical Decision Making**: Present scenarios requiring balance between profit and proper care
- **Long-term Planning**: Encourage strategic thinking about staff development and retirement planning