import "package:flutter/material.dart";

main() {
  runApp(MaterialApp(
    title: "Gamo Dictionary",
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {

  @override  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gamo-Dict"),
        backgroundColor: Color.fromARGB(255, 255, 193, 7)
        ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
                  Colors.deepOrange,
                  Colors.orangeAccent
                ])
              ),
              child: Text("This is drawer header")              
              ),
            CustomListTile(Icons.person, "Persons", ()=>{}),
            CustomListTile(Icons.dashboard, "Dashboard", ()=>{}),
            CustomListTile(Icons.offline_bolt, "Bolt", ()=>{}),
            CustomListTile(Icons.satellite, "Satelite", ()=>{}),
          ],
          )
        ),
      );
  }
}


class CustomListTile extends StatelessWidget {

  IconData icon;
  String title;
  Function onTap;

  CustomListTile(this.icon, this.title, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300))
        ),
        child: InkWell(
          splashColor: Colors.orangeAccent,
          onTap: onTap ,
          child: Container(
            height: 50,
            child: Row(
              children: <Widget>[
                Icon(icon),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: 
                    Text(title, style: TextStyle(
                    fontSize: 20.0
                    ),)
                ,),
              ],),
          ) 
        ),
      ));
    }
}