import 'dart:html';


close(event){
   
//  querySelector("#seleteditem").remove();
  querySelector("#rssfeeder").hidden=false;
  querySelector('#close').hidden=true;
  var seleteditemplace = querySelector("#seleteditem");
  if (seleteditemplace.hasChildNodes()) {
    
    seleteditemplace.children.clear();
  }
  
}