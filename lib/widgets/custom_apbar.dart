import 'package:find_hotel/screens/auth/login.dart';
import 'package:find_hotel/screens/auth/signup.dart';
import 'package:flutter/material.dart';

import '../gen/theme.dart';

AppBar BuildAppbar(String message) {
  return AppBar(
    backgroundColor: ksecondryColor,
    foregroundColor: Colors.white,
    elevation: 0,
    title: Text(message),
    centerTitle: true,
    actions: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              " ",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    ],
  );
}

AppBar searchAppBar(String message, BuildContext context) {
  return AppBar(
    title: Text(message),
    backgroundColor: ksecondryColor,
    foregroundColor: Colors.white,
    elevation: 0,
    actions: [
      IconButton(
          onPressed: () {
            showSearch(context: context, delegate: CustomSearch());
          },
          icon: Icon(Icons.search))
    ],
  );
}

class CustomSearch extends SearchDelegate {
  List<String> allData = [
    'American',
    "Russia",
    "China",
    "Italy",
    "Vietnam",
    "Germany",
    "Canada"
  ];
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<String> matchQuery = [];
    for (var item in allData) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in allData) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}

void redirect(BuildContext context, int index) {
  if (index == 1) {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => LogInScreen(),
      ),
    );
  } else if (index == 2) {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => SignUpScreen(),
      ),
    );
  } else if (index == 3) {
  } else if (index == 4) {
  } else {}
}
