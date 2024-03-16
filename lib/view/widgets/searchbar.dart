import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: 'Search Jobs',
      onChanged: (value) {},
      // controller: TextEditingController(),
      leading: const Icon(Icons.search_rounded),
      shape: MaterialStatePropertyAll(
        ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
      ),
    );
  }
}
