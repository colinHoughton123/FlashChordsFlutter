import 'package:flutter/material.dart';
import '../data/chord_xml_parser.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String output = "Loading...";

  @override
  void initState() {
    super.initState();
    _runTest();
  }

  Future<void> _runTest() async {
    final chords = await ChordXmlParser.load();
    setState(() {
      output = "Loaded ${chords.length} chords\n"
               "First: ${chords.first.name}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(output)),
    );
  }
}
