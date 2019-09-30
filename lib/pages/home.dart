import 'package:flutter/material.dart';
import 'package:gamo_dict/CustomShapeClipper.dart';
import "package:flutter/services.dart";

class HomeScreen extends StatelessWidget {

  @override  
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // systemNavigationBarColor: Colors.transparent, // navigation bar color
    statusBarColor: Colors.orange, // status bar color
  ));
    return Scaffold(
      appBar: AppBar(
        title: Text("Gamo-Dict"),
        elevation: 0.0,
        backgroundColor: Colors.orange,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.more_vert), onPressed: (){
            showSearch(context: context, delegate: WordSearch());
          },),
        ],
        ),
      drawer: Drawer(        
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: Text("This is drawer header", style: TextStyle(color: Colors.white),)              
              ),
            CustomListTile(Icons.home, "Home", ()=>{}),
            CustomListTile(Icons.history, "History", ()=>{}),
            CustomListTile(Icons.favorite_border, "Favourites", ()=>{}),
            CustomListTile(Icons.calendar_today, "Word of the Month", ()=>{}),
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

class HomeTopPart extends StatefulWidget {
  @override
  _HomeTopPartState createState() => _HomeTopPartState();
}

class _HomeTopPartState extends State<HomeTopPart> {
  bool isSelected = true;


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var textStyle = TextStyle(color: Colors.white, fontSize: 24.0);
    return Stack(
      children: <Widget>[
        ClipPath(clipper: CustomShapeClipper(), child: Container(height: height * 0.4, width: width, color: Colors.orange,
        child: Column(
          children: <Widget>[
            SizedBox(height: 40.0,),
            Text("Search Your Word", style: textStyle,textAlign: TextAlign.center,),
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
                      child: Icon(Icons.search, color: Colors.grey, ),
                      
                    ),
                    hintText: 'Enter Search Word',
                  ),
                ),
                ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  child: LangChoice("English", isSelected),
                  onTap: () {
                    setState(() {
                      isSelected = true;                      
                    });
                  },
                  ),
                SizedBox(width: 25,),
                InkWell(
                  child: LangChoice("አማርኛ", !isSelected), 
                  onTap: () {
                    setState(() {
                      isSelected = false;                      
                    });
                  },
                  ),
              ],
            )
          ],
        )
        ),)
      ],
    );
    
  }
}



class LangChoice extends StatefulWidget {
  final String lang;
  final bool selected;

  LangChoice(this.lang, this.selected);
  @override
  _LangChoiceState createState() => _LangChoiceState();
}

class _LangChoiceState extends State<LangChoice> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      decoration: widget.selected ? BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.all(Radius.circular(20.0))
      ) : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(widget.lang, style: TextStyle(color: Colors.white, fontSize: 18.0),),
          SizedBox(
            width: 4.0,
          ),
        ],
      ),
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
