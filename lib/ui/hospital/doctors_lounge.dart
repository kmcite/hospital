import 'package:flutter/material.dart';
import 'package:hospital/domain/api/doctors.dart';
import 'package:hospital/domain/models/doctor.dart';
import 'package:hospital/main.dart';

/// Repository providing lists of doctors
class DoctorsRepository {
  List<String> get onDuty => ["Dr. Smith", "Dr. Johnson", "Dr. Williams"];
  List<String> get onLeave => ["Dr. Brown"];
  List<String> get availableForHire => ["Dr. Jones", "Dr. Garcia"];
  List<String> get others => ["Dr. Miller", "Dr. Davis"];
}

/// DoctorsLounge Bloc
mixin DoctorsLoungeBloc {
  final getByStatus = doctorsRepository.getDoctorsByStatus;
  Iterable<Doctor> get onDutyDoctors => getByStatus();
  Iterable<Doctor> get onLeaveDoctors => getByStatus(DoctorStatus.onLeave);
  Iterable<Doctor> get hirable => getByStatus(DoctorStatus.availableForHire);
}

class DoctorsLounge extends UI with DoctorsLoungeBloc {
  DoctorsLounge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "DOCTORS LOUNGE",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),

          // Grid Layout (2x2)
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double width = constraints.maxWidth;
                final double height = constraints.maxHeight;

                return Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildQuadrant(
                                  "On Duty",
                                  onDutyDoctors,
                                ),
                              ),
                              Expanded(
                                child: _buildQuadrant(
                                  "On Leave",
                                  [],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildQuadrant(
                                  "Available for Hire",
                                  [],
                                ),
                              ),
                              Expanded(
                                child: _buildQuadrant(
                                  "Others",
                                  [],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Vertical Line
                    Positioned(
                      left: width / 2 - 1,
                      top: 0,
                      bottom: 0,
                      child: Container(width: 2, color: Colors.grey[400]),
                    ),

                    // Horizontal Line
                    Positioned(
                      top: height / 2 - 1,
                      left: 0,
                      right: 0,
                      child: Container(height: 2, color: Colors.grey[400]),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Helper method to build each quadrant
  Widget _buildQuadrant(String title, Iterable<Doctor> doctors) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300, blurRadius: 4, spreadRadius: 2),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          // List of Doctors
          Expanded(
            child: doctors.isNotEmpty
                ? ListView.separated(
                    itemCount: doctors.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1, color: Colors.grey),
                    itemBuilder: (_, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        doctors.elementAt(index).name,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                : const Center(child: Text("No doctors available")),
          ),
        ],
      ),
    );
  }
}
