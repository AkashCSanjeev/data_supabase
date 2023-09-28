import 'package:data_mnp/OdoData.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://ijulwidoqiiwomavldkj.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlqdWx3aWRvcWlpd29tYXZsZGtqIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTU5MDY3MDAsImV4cCI6MjAxMTQ4MjcwMH0.nYG186THZBMDAIaQ2K9SIWp0fOKQoW8f0cal-5q25Zk',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Data-Simulation-App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: OdoData(),
      ),
    );
  }
}
