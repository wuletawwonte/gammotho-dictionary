import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gamo_dict/CustomShapeClipper.dart';
import 'package:flutter/services.dart';
import 'package:gamo_dict/pages/history.dart';
// import 'dart:async';
import 'package:gamo_dict/sqlite/word.dart';
import 'package:gamo_dict/sqlite/db_helper.dart';

// import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class HomeScreen extends StatelessWidget {

  @override  
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // systemNavigationBarColor: Colors.transparent, // navigation bar color
      statusBarColor: Colors.orange, // status bar color
      ));
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Gamo-Dict"),
        elevation: 0.0,
        backgroundColor: Colors.orange,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.settings), onPressed: (){}),
        ],
        ),
      drawer: Drawer(        
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/drawerbg.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Text("", style: TextStyle(color: Colors.white),)              
              ),
            CustomListTile(Icons.home, "Home", ()=>{}),
            CustomListTile(Icons.history, "History", () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) {
                  return History();
                }
              ));
            }),
            CustomListTile(Icons.favorite_border, "Favourites", ()=>{}),
            CustomListTile(Icons.calendar_today, "Word of the Month", ()=>{}),
            Divider(),
            CustomListTile(Icons.share, "Share App", ()=>{}),
            CustomListTile(Icons.rate_review, "Rate and Review", ()=>{}),
            CustomListTile(Icons.perm_identity, "About", ()=>{}),
          ],
          )
        ),
      body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  HomeTopPart(),
                  SizedBox(height: 20.0,),
                  HomeBottomPart(),
                ],
              ),
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
  List<Word> words = [];
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper =  DBHelper();
    getWords();
  }

  getWords() {
    // List<Word> kword;
    dbHelper.getWords().then((word){
      print("length: " + word.length.toString());  
    }).catchError((e) {
      print(e.toString());
    });
    // return kword;
  } 

  Widget row(Word item) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black26)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(item.word, style: TextStyle(fontSize: 22, color: Colors.black54),),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    var textStyle = TextStyle(color: Colors.white, fontSize: 24.0);
    return Stack(
      children: <Widget>[
        ClipPath(clipper: CustomShapeClipper(), child: Container(height: 300, width: width, color: Colors.orange,
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
                child: AutoCompleteTextField<Word>(
                  key: GlobalKey(),
                  suggestions: words,
                  itemFilter: (item, query) {
                    return item.word.toLowerCase().startsWith(query.toLowerCase());
                  },
                  itemSorter: (a, b) {
                    return a.word.compareTo(b.word);
                  },
                  itemSubmitted: (item) {

                  },
                  itemBuilder: (context, item) {
                    return row(item);
                                      },
                                      decoration: InputDecoration(
                                        // cursorColor: Colors.grey,
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 13.0),
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
                            ),
                            ),
                            )
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

class HomeBottomPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),    
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              leading: Icon(Icons.calendar_today, color: Colors.lightBlue,),
              title: Text('Word of the day'),
              subtitle: Text('Wongela'),
            )
          ],
        ),
      ),
    );


  }
}

