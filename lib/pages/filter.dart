import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

/// call these global variables when applying filter
// Property category
bool forRent = false, forLease = false, forSale = false, allCategory = true;

// Property type
bool land = false, apartment = false, allType = true;

// Property location
String propertyLocation = "All locations";

class _FilterPageState extends State<FilterPage> {
  /// if no category is selected, [allCategories] go true
  void checkCategories(value) {
    if (value == false &&
        forRent == false &&
        forLease == false &&
        forSale == false) {
      setState(() {
        allCategory = true;
      });
    }
  }

  /// if no type is selected, [allTypes] go true
  void checkTypes(value) {
    if (value == false && land == false && apartment == false) {
      setState(() {
        allType = true;
      });
    }
  }

  // TODO: use where location is; to display from specific location
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Filter"),
      ),
      body: ListView(children: [
        const ListTile(title: Text("Select property category:")),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const SizedBox(width: 20),
            FilterChip(
              label: const Text("For Rent"),
              selected: forRent,
              onSelected: (value) {
                checkCategories(value);
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
            const SizedBox(width: 20),
            FilterChip(
              label: const Text("For Lease"),
              selected: forLease,
              onSelected: (value) {
                checkCategories(value);
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
            const SizedBox(width: 20),
            FilterChip(
              label: const Text("For Sale"),
              selected: forSale,
              onSelected: (value) {
                checkCategories(value);
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
            const SizedBox(width: 20),
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
                if (forRent == false && forLease == false && forSale == false) {
                  setState(() {
                    allCategory = true;
                  });
                } else {
                  setState(() {
                    allCategory = value;
                  });
                }
              },
            ),
            const SizedBox(width: 20),
          ],
        ),

        //
        //
        /// Section for property type
        const Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: ListTile(title: Text("Select property type:")),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const SizedBox(width: 20),
            FilterChip(
              label: const Text("Land"),
              selected: land,
              onSelected: (value) {
                checkTypes(value);
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
            const SizedBox(width: 20),
            FilterChip(
              label: const Text("Apartment"),
              selected: apartment,
              onSelected: (value) {
                checkTypes(value);
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
            const SizedBox(width: 20),
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
            const SizedBox(width: 20),
          ],
        ),

//
//
        /// Section for property location
        const Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: ListTile(
            title: Text("Select Location:"),
          ),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              width: 136,
              child: RadioMenuButton(
                  value: "Eldoret",
                  groupValue: propertyLocation,
                  onChanged: (value) {
                    setState(() {
                      propertyLocation = value!;
                    });
                  },
                  child: const Text("Eldoret")),
            ),
            SizedBox(
              width: 136,
              child: RadioMenuButton(
                  value: "Githunguri",
                  groupValue: propertyLocation,
                  onChanged: (value) {
                    setState(() {
                      propertyLocation = value!;
                    });
                  },
                  child: const Text("Githunguri")),
            ),
            SizedBox(
              width: 136,
              child: RadioMenuButton(
                  value: "Juja",
                  groupValue: propertyLocation,
                  onChanged: (value) {
                    setState(() {
                      propertyLocation = value!;
                    });
                  },
                  child: const Text("Juja")),
            ),
            SizedBox(
              width: 136,
              child: RadioMenuButton(
                  value: "Kabete",
                  groupValue: propertyLocation,
                  onChanged: (value) {
                    setState(() {
                      propertyLocation = value!;
                    });
                  },
                  child: const Text("Kabete")),
            ),
            SizedBox(
              width: 136,
              child: RadioMenuButton(
                  value: "Kiambu",
                  groupValue: propertyLocation,
                  onChanged: (value) {
                    setState(() {
                      propertyLocation = value!;
                    });
                  },
                  child: const Text("Kiambu")),
            ),
            SizedBox(
              width: 136,
              child: RadioMenuButton(
                  value: "Kikuyu",
                  groupValue: propertyLocation,
                  onChanged: (value) {
                    setState(() {
                      propertyLocation = value!;
                    });
                  },
                  child: const Text("Kikuyu")),
            ),
            SizedBox(
              width: 136,
              child: RadioMenuButton(
                  value: "Laikipia",
                  groupValue: propertyLocation,
                  onChanged: (value) {
                    setState(() {
                      propertyLocation = value!;
                    });
                  },
                  child: const Text("Laikipia")),
            ),
            SizedBox(
              width: 136,
              child: RadioMenuButton(
                  value: "Malaa",
                  groupValue: propertyLocation,
                  onChanged: (value) {
                    setState(() {
                      propertyLocation = value!;
                    });
                  },
                  child: const Text("Malaa")),
            ),
            SizedBox(
              width: 136,
              child: RadioMenuButton(
                  value: "Matuu",
                  groupValue: propertyLocation,
                  onChanged: (value) {
                    setState(() {
                      propertyLocation = value!;
                    });
                  },
                  child: const Text("Matuu")),
            ),
            SizedBox(
              width: 136,
              child: RadioMenuButton(
                  value: "Mombasa",
                  groupValue: propertyLocation,
                  onChanged: (value) {
                    setState(() {
                      propertyLocation = value!;
                    });
                  },
                  child: const Text("Mombasa")),
            ),
            SizedBox(
              width: 136,
              child: RadioMenuButton(
                  value: "Nairobi",
                  groupValue: propertyLocation,
                  onChanged: (value) {
                    setState(() {
                      propertyLocation = value!;
                    });
                  },
                  child: const Text("Nairobi")),
            ),
            SizedBox(
              width: 136,
              child: RadioMenuButton(
                  value: "Naivasha",
                  groupValue: propertyLocation,
                  onChanged: (value) {
                    setState(() {
                      propertyLocation = value!;
                    });
                  },
                  child: const Text("Naivasha")),
            ),
            SizedBox(
              width: 136,
              child: RadioMenuButton(
                  value: "Nakuru",
                  groupValue: propertyLocation,
                  onChanged: (value) {
                    setState(() {
                      propertyLocation = value!;
                    });
                  },
                  child: const Text("Nakuru")),
            ),
            SizedBox(
              width: 136,
              child: RadioMenuButton(
                  value: "Ruaka",
                  groupValue: propertyLocation,
                  onChanged: (value) {
                    setState(() {
                      propertyLocation = value!;
                    });
                  },
                  child: const Text("Ruaka")),
            ),
            SizedBox(
              width: 136,
              child: RadioMenuButton(
                  value: "Syokimau",
                  groupValue: propertyLocation,
                  onChanged: (value) {
                    setState(() {
                      propertyLocation = value!;
                    });
                  },
                  child: const Text("Syokimau")),
            ),
            SizedBox(
              width: 136,
              child: RadioMenuButton(
                  value: "Thika",
                  groupValue: propertyLocation,
                  onChanged: (value) {
                    setState(() {
                      propertyLocation = value!;
                    });
                  },
                  child: const Text("Thika")),
            ),
            SizedBox(
              width: 180,
              child: RadioMenuButton(
                  value: "All locations",
                  groupValue: propertyLocation,
                  onChanged: (value) {
                    setState(() {
                      propertyLocation = value!;
                    });
                  },
                  child: const Text("All locations")),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: OutlinedButton(
              style: ButtonStyle(
                  side: MaterialStateProperty.resolveWith((states) =>
                      BorderSide(color: Theme.of(context).primaryColor))),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Apply Filter",
                      style: TextStyle(
                          fontSize: 18, color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(width: 20),
                    Icon(
                      Icons.done,
                      size: 32,
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              )),
        ),
      ]),
    );
  }
}
