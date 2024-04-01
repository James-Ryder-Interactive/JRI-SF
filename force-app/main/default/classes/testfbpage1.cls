public class testfbpage1 {
    public String id1{get;set;}
    public String name1{get;set;}
    public String website1{get;set;}
    public String fancount1{get;set;}
    
    public testfbpage1()
    {
    Http http = new Http();
    HttpRequest  req = new HttpRequest();
 	req.setEndPoint('https://graph.facebook.com/2740781692741695?fields=id,name,website,fan_count,posts&access_token=EAAm8ufcz6D8BOxNXBsQ2Cwg1Cw6vhGXZAyHZBGrWnzgvGgRDaYsGxPOYgAxxPlCWBJGOfoxoe6jnjGOSSXdKiP8HirRqHtsRFoxu21q0pTZBSkApyk8im7iUE1tUCCdwkhGuzuzZBZBD44DoK4DayCtli4KykxA5DF4RKSqXugpPFgKFR4d2fwzm57QUnnQd3iv0xGlX6JHxyv2uNcMOZAQgFjwqxO2NuavDKqitRavAyZAJ3ts1EXkzpHthVNsDGMZD');
    
    req.setMethod('GET');
    HttpResponse res = http.send(req);
    
    String str = res.getBody();
    
    JSON2Apex myClass = JSON2Apex.parse(str);
    id1=myClass.id;
    name1 = myClass.name;
    website1 = myClass.website;
    fancount1 = myClass.fan_count;    
    }
}