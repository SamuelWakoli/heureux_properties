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
bool farm = false, land = false, plot = false, ranch = false, allType = true;

// Property location
String propertyLocation = "All locations";

class _FilterPageState extends State<FilterPage> {
  /// If no category is selected, [allCategories] go true.
  /// Call this functions at the end of onSelected parameter of FilterChip
  void checkCategories(value) {
    if (value == false &&
        forRent == false &&
        forLease == false &&
        forSale == false) {
      setState(() {
        allCategory = true;
      });
    }

    if (value == true &&
        forRent == true &&
        forLease == true &&
        forSale == true) {
      setState(() {
        allCategory = true;
        forRent = false;
        forLease = false;
        forSale = false;
      });
    }
  }

  /// If no type is selected, [allTypes] go true.
  /// Call this functions at the end of onSelected parameter of FilterChip.
  void checkTypes(value) {
    if (value == false &&
        farm == false &&
        land == false &&
        plot == false &&
        ranch == false) {
      setState(() {
        allType = true;
      });
    }
    if (value == true &&
        farm == true &&
        land == true &&
        plot == true &&
        ranch == true) {
      setState(() {
        allType = true;
        farm = false;
        land = false;
        plot = false;
        ranch = false;
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
                // if this value is true, unselect all categories
                if (value == true) {
                  setState(() {
                    allCategory = false;
                  });
                }
                setState(() {
                  forRent = value;
                });

                checkCategories(value);
              },
            ),
            const SizedBox(width: 20),
            FilterChip(
              label: const Text("For Lease"),
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

                checkCategories(value);
              },
            ),
            const SizedBox(width: 20),
            FilterChip(
              label: const Text("For Sale"),
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

                checkCategories(value);
              },
            ),
            const SizedBox(width: 20),
            FilterChip(
              label: const Text("All categories"),
              selected: allCategory,
              onSelected: (value) {
                // if no category is selected allCategory remains unchanged
                if (allCategory == true &&
                    forRent == false &&
                    forLease == false &&
                    forSale == false) {
                  // tell user
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Property category cannot be empty'),
                    ),
                  );
                }
                // when user selects all category, all other chips go false
                else if (value == true) {
                  setState(() {
                    forRent = false;
                    forLease = false;
                    forSale = false;
                    allCategory = value;
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
              label: const Text("Farm"),
              selected: farm,
              onSelected: (value) {
                // if this value is true, unselect all types
                if (value == true) {
                  setState(() {
                    allType = false;
                  });
                }
                setState(() {
                  farm = value;
                });

                checkTypes(value);
              },
            ),
            const SizedBox(width: 20),
            FilterChip(
              label: const Text("Land"),
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

                checkTypes(value);
              },
            ),
            const SizedBox(width: 20),
            FilterChip(
              label: const Text("Plot"),
              selected: plot,
              onSelected: (value) {
                // if this value is true, unselect all types
                if (value == true) {
                  setState(() {
                    allType = false;
                  });
                }
                setState(() {
                  plot = value;
                });

                checkTypes(value);
              },
            ),
            const SizedBox(width: 20),
            FilterChip(
              label: const Text("Ranch"),
              selected: ranch,
              onSelected: (value) {
                // if this value is true, unselect all types
                if (value == true) {
                  setState(() {
                    allType = false;
                  });
                }
                setState(() {
                  ranch = value;
                });

                checkTypes(value);
              },
            ),
            const SizedBox(width: 20),
            FilterChip(
                label: const Text("All types"),
                selected: allType,
                onSelected: (value) {
                  // if no type is selected, AllType should not change
                  if (allType == true &&
                      farm == false &&
                      land == false &&
                      plot == false &&
                      ranch == false) {
                    // tell user
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Property type cannot be empty'),
                      ),
                    );
                  }
                  // when user selects all types, all other chips go false
                  else if (value == true) {
                    setState(() {
                      farm = false;
                      land = false;
                      plot = false;
                      ranch = false;
                      allType = value;
                    });
                  } else {
                    setState(() {
                      allType = value;
                    });
                  }
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
      ]),
    );
  }
}
