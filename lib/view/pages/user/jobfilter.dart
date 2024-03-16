import 'dart:ffi';

import 'package:flutter/material.dart';

class JobFilter extends StatefulWidget {
  const JobFilter({super.key});

  @override
  State<JobFilter> createState() => _JobFilterState();
}

class _JobFilterState extends State<JobFilter> {
  List<DropdownMenuEntry<dynamic>> jobList = [
    const DropdownMenuEntry(
        value: 'Front-end Developer', label: 'Front-end Developer'),
    const DropdownMenuEntry(
        value: 'Backend Developer', label: 'Backend Developer'),
    const DropdownMenuEntry(
        value: 'Full Stack Developer', label: 'Full Stack Developer'),
    const DropdownMenuEntry(
        value: 'Mobile Developer', label: 'Mobile Developer'),
    const DropdownMenuEntry(
        value: 'Desktop Developer', label: 'Desktop Developer'),
    const DropdownMenuEntry(value: 'Cloud Developer', label: 'Cloud Developer'),
    const DropdownMenuEntry(value: 'DevOps Engieer', label: 'DevOps Engieer'),
    const DropdownMenuEntry(value: 'Game Developer', label: 'Game Developer'),
    const DropdownMenuEntry(value: 'QA Engineer', label: 'QA Engineer'),
    const DropdownMenuEntry(
        value: 'System Administrator', label: 'System Administrator'),
    const DropdownMenuEntry(value: 'UI/UX Engineer', label: 'UI/UX Engineer'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter'),
      ),
      body: Column(
        children: [
          const Text('Industry'),
          DropdownMenu(
            dropdownMenuEntries: jobList,
            enableFilter: true,
            menuHeight: MediaQuery.of(context).size.height * 0.2,
          ),
        ],
      ),
    );
  }
}
