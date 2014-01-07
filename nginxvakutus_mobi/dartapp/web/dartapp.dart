import 'dart:html';
import "package:jsonp/jsonp.dart" as jsonp;
import "package:js/js.dart" as js;
import "dart:async";
import 'domains.dart';
import 'package:intl/intl.dart';
import 'events/clickonitemevent.dart' as clickonitemevent;

List<ForMark> forMarkList;
var rssfeeder;

void main() {
  
  forMarkList = new List<ForMark>();
  
  Future<js.Proxy> result = jsonp.fetch(
      uri: "http://suomipornome2.appspot.com/jsonout?locale=fi_FI&themes=finances&subthemes=Ulkomaat&callback=?"
  );
  result.then((js.Proxy proxy) {
       
    for (var i=0;i < proxy["results"].length;i++){
      
      ForMark forMark = new ForMark();
      
      forMark.Description = proxy["results"][i]["Description"];
      DateTime pubDate = DateTime.parse(proxy["results"][i]["PubDate"]);
      var timeStamp = new DateFormat("d-MMM-yyyy");
      String pubDateStr = timeStamp.format(pubDate);
      forMark.PubDate = pubDateStr;
      forMark.Title = proxy["results"][i]["Title"];
      forMark.ImageLink = proxy["results"][i]["ImageLink"];
      forMark.Cont = proxy["results"][i]["Cont"];
      forMarkList.add(forMark);
    }
//    js.release(proxy);

    for (var i=0;i < forMarkList.length;i++){
      
      createMediaObject(i,forMarkList[i]);
      
    }
    
  });
  
  rssfeeder = querySelector("#rssfeeder");
  
}

createMediaObject(i,ForMark item){
  var id = i.toString();
  var title ="<i class='fa fa-share fa-2x'></i><div class='googlefonttitle'>"+item.Title+".</div>";
  var pubdate = item.PubDate;
  var imagelink = item.ImageLink;
  var cont = "<p class='media-heading googlefontcont'>"+item.Cont.substring(0, 25)+"...</p>";
  
  var htmlstr = "<div class='media'><img class='media-object pull-left img-thumbnail itemimage' src='${imagelink}' alt=''><div class='media-body'> <h4 class='media-heading'>${title}</h4>${cont}</div></div>";
  
  var divElement = new DivElement();
  divElement.onClick.listen((event) => clickonitemevent.show(event,forMarkList));

  divElement.setInnerHtml(htmlstr, treeSanitizer: new NullTreeSanitizer() );
  divElement.id =id; 
  
  rssfeeder.append(divElement);
  
  
}
class NullTreeSanitizer implements NodeTreeSanitizer {
  void sanitizeTree(Node node) {}
}
