class DashboardStats {
  final int numPatients;
  final int numAppointments;
  final int numSessions;

  const DashboardStats({
    required this.numPatients,
    required this.numAppointments,
    required this.numSessions,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    int def_numPatients;
    int def_numAppointments;
    int def_numSessions;

    def_numPatients = json['num_patients'] ?? 0;
    def_numAppointments = json['num_appointments_req'] ?? 0;
    def_numSessions = json['num_todays_sessions'] ?? 0;

    return DashboardStats(
      numPatients: def_numPatients as int,
      numAppointments: def_numAppointments as int,
      numSessions: def_numSessions as int,
    );
  }
}
