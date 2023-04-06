import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  // Property category
  bool forRent = false, forLease = false, forSale = false, allCategory = true;

  // Property type
  bool land = false, apartment = false, allType = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Filter"),
      ),
      body: ListView(children: [
        ListTile(title: Text("Select property category:")),
        Row(
          children: [
            SizedBox(width: 20),
            FilterChip(
              label: Text("For Rent"),
              selected: forRent,
              onSelected: (value) {
                // if this value is true, unselect all categories
                if (value == true) {
                  setState(() {
                    allCategory = false;
                  });
                }
                setState(() {
                  forRent = value;
                });
              },
            ),
            SizedBox(width: 20),
            FilterChip(
              label: Text("For Lease"),
              selected: forLease,
              onSelected: (value) {
                // if this value is true, unselect all categories
                if (value == true) {
                  setState(() {
                    allCategory = false;
                  });
                }
                setState(() {
                  forLease = value;
                });
              },
            ),
            SizedBox(width: 20),
            FilterChip(
              label: Text("For Sale"),
              selected: forSale,
              onSelected: (value) {
                // if this value is true, unselect all categories
                if (value == true) {
                  setState(() {
                    allCategory = false;
                  });
                }
                setState(() {
                  forSale = value;
                });
              },
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(width: 20),
            FilterChip(
              label: const Text("All categories"),
              selected: allCategory,
              onSelected: (value) {
                // when user selects all category, all other chips go false
                if (value == true) {
                  setState(() {
                    forRent = false;
                    forLease = false;
                    forSale = false;
                  });
                }
                setState(() {
                  allCategory = value;
                });
              },
            ),
            SizedBox(width: 20),
          ],
        ),
        SizedBox(height: 20),
        ListTile(title: Text("Select property type:")),
        Row(
          children: [
            SizedBox(width: 20),
            FilterChip(
              label: Text("Land"),
              selected: land,
              onSelected: (value) {
                // if this value is true, unselect all types
                if (value == true) {
                  setState(() {
                    allType = false;
                  });
                }
                setState(() {
                  land = value;
                });
              },
            ),
            SizedBox(width: 20),
            FilterChip(
              label: Text("Apartment"),
              selected: apartment,
              onSelected: (value) {
                // if this value is true, unselect all types
                if (value == true) {
                  setState(() {
                    allType = false;
                  });
                }
                setState(() {
                  apartment = value;
                });
              },
            ),
            SizedBox(width: 20),
          ],
        ),
        Row(
          children: [
            SizedBox(width: 20),
            FilterChip(
                label: const Text("All types"),
                selected: allType,
                onSelected: (value) {
                  // when user selects all types, all other chips go false
                  if (value == true) {
                    setState(() {
                      land = false;
                      apartment = false;
                    });
                  }
                  setState(() {
                    allType = value;
                  });
                }),
            SizedBox(width: 20),
          ],
        ),
        SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(),
        )
      ]),
    );
  }
}
