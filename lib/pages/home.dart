import 'package:flutter/material.dart';
import 'package:gamo_dict/CustomShapeClipper.dart';

class HomeScreen extends StatelessWidget {

  @override  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gamo-Dict"),
        elevation: 0.0,
        backgroundColor: Colors.orange,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.more_vert), onPressed: (){
            showSearch(context: context, delegate: WordSearch());
          },)
        ],

        ),
      drawer: Drawer(        
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Text("This is drawer header")              
              ),
            CustomListTile(Icons.translate, "Dictionary", ()=>{}),
            CustomListTile(Icons.dashboard, "Dashboard", ()=>{}),
            CustomListTile(Icons.favorite_border, "Favourite", ()=>{}),
            CustomListTile(Icons.offline_bolt, "Bolt", ()=>{}),
            CustomListTile(Icons.satellite, "Satelite", ()=>{}),
            Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade400))
              ),
              child: ListTile(
                title: Text("Others", style: TextStyle(fontSize: 18)),
                ),
            ),
            CustomListTile(Icons.share, "Share App", ()=>{}),
            CustomListTile(Icons.rate_review, "Rate and Review", ()=>{}),
            CustomListTile(Icons.perm_identity, "About", ()=>{}),
          ],
          )
        ),
      body: Column(
        children: <Widget>[
          HomeTopPart()
        ],
      ),
      );
  }
}

class HomeTopPart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        ClipPath(clipper: CustomShapeClipper(), child: Container(height: height * 0.4, width: width, color: Colors.orange,
        child: Column(
          children: <Widget>[
            SizedBox(height: 50.0,),
            Text("Search your Word", style: TextStyle(color: Colors.white, fontSize: 24.0),textAlign: TextAlign.center,),
            SizedBox(height: 30.0,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                child: TextField(
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 13.0),
                    suffixIcon: Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      child: Icon(Icons.search, color: Colors.grey,)
                    ),
                  ),
                ),
                ),
            )
          ],
        )
        ),)
      ],
    );
  }
}

class CustomListTile extends StatelessWidget {

  final IconData icon;
  final String title;
  final Function onTap;

  CustomListTile(this.icon, this.title, this.onTap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
          splashColor: Colors.orangeAccent,
          onTap: onTap ,
          child: Container(
            height: 50,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(icon),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: 
                    Text(title, style: TextStyle(
                    fontSize: 18.0
                    ),)
                ,),
              ],), 
            ),
          );
    }
}
class WordSearch extends SearchDelegate<String> {
  final words = ["Abebe", "Besso", "Cala", "Demo", "Endalew"];
  final recentWords = ["Abebe", "Demo"];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: (){},)];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ), 
      onPressed: (){});
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty?recentWords:words;

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.location_city),
        title: Text(suggestionList[index])
      ),
      itemCount: suggestionList.length,
    );
  }}
