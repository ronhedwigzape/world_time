import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {
  
    String location; // location name for the UI
    late String time; // the time in that location
    String flag; // url to an asset flag icon
    String url; // location url for api endpoint
    late bool isDaytime; // true or false if daytime or not
  
    WorldTime({required this.location, required this.flag, required this.url});
  
    Future<void> getTime() async {
  
      // make try/catch block to catch errors 
      try {
        // make the request
        Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
        Map data = jsonDecode(response.body);
        // print(data);
  
        // get properties from data
        String datetime = data['datetime'];
        String offset = data['utc_offset'].substring(1,3);
        // print(datetime);
        // print(offset);
  
        // create DateTime object
        DateTime now = DateTime.parse(datetime);
        now = now.add(Duration(hours: int.parse(offset)));
  
        // set the time property
        isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
        time = now.toString();
      }
      catch (e) {
        print('caught error: $e'); // print error to console
        time = 'could not get time data'; // set time to error message
      } 
  
    }
}

//
WorldTime instance = WorldTime(location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');