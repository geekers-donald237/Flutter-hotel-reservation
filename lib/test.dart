 Container(
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              child: Image.network(
                  "https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/118898040/original/870e2763755963f5a300574bbea5977fa8b18460/sell-original-football-and-basketball-teams-jersey.jpg",
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill),
            ),
            Column(
              children: [
                Container(
                  child: Text('items[index].title',
                      // style: titleTextStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                      child: Text(
                        'items[index].subtitle',
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );


     Container(
      child: Card(
        elevation: 0.4,
        shadowColor: kblack,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Column(
            children: [
              Hero(
                tag: '${activity.id}_${activity.title}',
                child: Container(
                  height: masonryCardHeights[index % 2],
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    border: Border(
                      bottom: BorderSide(color: kgrey),
                    ),
                    image: DecorationImage(
                      image: AssetImage(activity
                          .imagePath), // Utilise AssetImage au lieu de Image.asset
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Cards Title 1",
                style: TextStyle(
                    fontFamily: 'worksans',
                    fontSize: 13,
                    backgroundColor: kblue,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              Text(
                MyStringsSample.card_text,
                maxLines: 2,
                style: MyTextSample.subhead(context)!.copyWith(
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );

 