import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ===================== MyApp =====================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

// ===================== Login Page =====================
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Unique Logo
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.blue.shade700,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  "DS AT",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Welcome to Attendance App",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 50),

            // Login Button (no email/password)
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AttendanceScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  "Enter",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===================== Attendance Page =====================
class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  int selectedHour = 0;

  List<Map<String, dynamic>> schedule = [
    {"hour": "Hour 1", "subject": "DBMS", "staff": "Ajitha"},
    {"hour": "Hour 2", "subject": "TOC", "staff": "Raja Vadhani"},
    {"hour": "Hour 3", "subject": "AL", "staff": "Uma"},
    {"hour": "Hour 4", "subject": "AIML", "staff": "Priyadharshini"},
    {"hour": "Hour 5", "subject": "OS", "staff": "Nisha"},
    {"hour": "Hour 6", "subject": "ESS", "staff": "Umasankar"},
    {"hour": "Hour 7", "subject": "DBMS", "staff": "Ajitha"},
    {"hour": "Hour 8", "subject": "AIML", "staff": "Priyadharshini"},
  ];

  List<Map<String, String>> students = [
    {"name": "Arun", "status": ""},
    {"name": "Priya", "status": ""},
    {"name": "Rahul", "status": ""},
    {"name": "Meena", "status": ""},
    {"name": "Karthik", "status": ""},
    {"name": "Vijay", "status": ""},
    {"name": "Divya", "status": ""},
    {"name": "Sanjay", "status": ""},
  ];

  void updateStatus(int index, String status) {
    setState(() {
      students[index]["status"] = status;
    });
  }

  Color getColor(String status) {
    if (status == "P") return Colors.green.shade200;
    if (status == "A") return Colors.red.shade200;
    if (status == "OD") return Colors.yellow.shade200;
    return Colors.white;
  }

  int totalPresent() => students.where((s) => s["status"] == "P").length;
  int totalAbsent() => students.where((s) => s["status"] == "A").length;
  int totalOnDuty() => students.where((s) => s["status"] == "OD").length;
  double attendancePercentage() => students.isEmpty ? 0 : (totalPresent() / students.length) * 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Attendance"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          // Hour selection dropdown
          DropdownButton<int>(
            value: selectedHour,
            items: List.generate(schedule.length, (index) {
              return DropdownMenuItem(
                value: index,
                child: Text(schedule[index]["hour"]),
              );
            }),
            onChanged: (value) {
              setState(() {
                selectedHour = value!;
              });
            },
          ),

          const SizedBox(height: 5),

          // Subject & Staff display
          Text(
            "Subject: ${schedule[selectedHour]["subject"]}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            "Staff: ${schedule[selectedHour]["staff"]}",
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),

          // Student list
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                String status = students[index]["status"]!;
                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 4,
                  color: getColor(status),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              students[index]["name"]!,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            Text(
                              status == "" ? "Not Marked" : status,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              onPressed: () => updateStatus(index, "P"),
                              child: const Text("P"),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () => updateStatus(index, "A"),
                              child: const Text("A"),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                              ),
                              onPressed: () => updateStatus(index, "OD"),
                              child: const Text(
                                "OD",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom summary
          Container(
            color: Colors.blue.shade100,
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Total Members: ${students.length}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      "Total P: ${totalPresent()}",
                      style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      "Total A: ${totalAbsent()}",
                      style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      "Total OD: ${totalOnDuty()}",
                      style: const TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  "Attendance %: ${attendancePercentage().toStringAsFixed(2)}%",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}