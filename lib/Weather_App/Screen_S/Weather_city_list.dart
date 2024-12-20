import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/Weather_App/Screen_S/Current_screen_UI.dart';

// Main function to run the app
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WeatherCityList(),
  ));
}

class WeatherCityList extends StatefulWidget {
  @override
  _WeatherCityListState createState() => _WeatherCityListState();
}

class _WeatherCityListState extends State<WeatherCityList> {
  List<String> cityList = [];
  final TextEditingController _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCityList();
  }

  _loadCityList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cityList = prefs.getStringList('cityList') ?? [
        // Add your default city list here (as in your original code)
        // Andhra Pradesh
        'Visakhapatnam',
        'Vijayawada',
        'Guntur',
        'Nellore',
        'Kurnool',
        // Arunachal Pradesh
        'Itanagar',
        'Tawang',
        'Ziro',
        'Pasighat',
        'Bomdila',
        // Assam
        'Guwahati',
        'Dibrugarh',
        'Silchar',
        'Jorhat',
        'Tezpur',
        // Bihar
        'Patna',
        'Gaya',
        'Bhagalpur',
        'Muzaffarpur',
        'Darbhanga',
        // Chhattisgarh
        'Raipur',
        'Bhilai',
        'Bilaspur',
        'Korba',
        'Durg',
        // Goa
        'Panaji',
        'Margao',
        'Vasco da Gama',
        'Ponda',
        // Gujarat
        'Ahmedabad',
        'Surat',
        'Vadodara',
        'Rajkot',
        'Bhavnagar',
        // Haryana
        'Gurugram',
        'Faridabad',
        'Panipat',
        'Karnal',
        'Hisar',
        // Himachal Pradesh
        'Shimla',
        'Manali',
        'Dharamshala',
        'Solan',
        'Mandi',
        // Jharkhand
        'Ranchi',
        'Jamshedpur',
        'Dhanbad',
        'Bokaro',
        'Deoghar',
        // Karnataka
        'Bengaluru',
        'Mysuru',
        'Mangaluru',
        'Hubballi',
        'Belagavi',
        // Kerala
        'Thiruvananthapuram',
        'Kochi',
        'Kozhikode',
        'Kannur',
        'Thrissur',
        // Madhya Pradesh
        'Bhopal',
        'Indore',
        'Gwalior',
        'Jabalpur',
        'Ujjain',
        // Maharashtra
        'Mumbai',
        'Pune',
        'Nagpur',
        'Nashik',
        'Thane',
        // Manipur
        'Imphal',
        'Churachandpur',
        'Bishnupur',
        // Meghalaya
        'Shillong',
        'Tura',
        'Jowai',
        // Mizoram
        'Aizawl',
        'Lunglei',
        'Champhai',
        // Nagaland
        'Kohima',
        'Dimapur',
        'Mokokchung',
        // Odisha
        'Bhubaneswar',
        'Cuttack',
        'Rourkela',
        'Puri',
        'Berhampur',
        // Punjab
        'Amritsar',
        'Ludhiana',
        'Jalandhar',
        'Patiala',
        'Bathinda',
        // Rajasthan
        'Jaipur',
        'Udaipur',
        'Jodhpur',
        'Kota',
        'Ajmer',
        // Sikkim
        'Gangtok',
        'Namchi',
        // Tamil Nadu
        'Chennai',
        'Coimbatore',
        'Madurai',
        'Tiruchirappalli',
        'Salem',
        // Telangana
        'Hyderabad',
        'Warangal',
        'Nizamabad',
        'Karimnagar',
        'Khammam',
        // Tripura
        'Agartala',
        'Dharmanagar',
        // Uttar Pradesh
        'Lucknow',
        'Kanpur',
        'Varanasi',
        'Agra',
        'Prayagraj',
        // Uttarakhand
        'Dehradun',
        'Haridwar',
        'Nainital',
        'Rishikesh',
        // West Bengal
        'Kolkata',
        'Howrah',
        'Darjeeling',
        'Siliguri',
        'Durgapur',
        // Union Territories
        'Delhi',
        'Chandigarh',
        'Puducherry',
        'Jammu',
        'Srinagar',
        'Leh',
        'Kavaratti',
        'Port Blair',
        'Daman',
        'Silvassa',
        'Diu',

         ];
    });
  }

  _saveCityList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('cityList', cityList);
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(
                'Enter Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildTextField('Current'),
              _buildTextField('Forecast'),
              _buildTextField('Search/Autocomplete'),
              _buildTextField('History'),
              _buildTextField('Alerts'),
              _buildTextField('Future'),
              _buildTextField('Marine'),
              _buildTextField('Astronomy'),
              _buildTextField('Time Zone'),
              _buildTextField('Sports'),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle Save button press
                    Navigator.pop(context);
                  },
                  child: Text('Save'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: InkWell(
              onTap: () => _showBottomSheet(context),
              child: Icon(Icons.open_in_new, color: Colors.white),
            ),
          ),
        ],
        centerTitle: true,
        title: Text(
          'Weather City List',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Itim',
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                hintStyle: TextStyle(fontFamily: 'Itim', fontSize: 15),
                hintText: "Enter City Name",
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(width: 2, color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(width: 2, color: Colors.blue),
                ),
                labelText: 'Enter City Name',
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: cityList.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        trailing: const FaIcon(
                          FontAwesomeIcons.cloudSun,
                          size: 30,
                          color: Colors.orange,
                        ),
                        title: Text(
                          cityList[index],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Itim',
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CurrentScreen(city: cityList[index]),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade700,
        onPressed: () {
          setState(() {
            if (_cityController.text.isNotEmpty) {
              cityList.add(_cityController.text);
              _cityController.clear();
              _saveCityList();
            }
          });
        },
        child: const FaIcon(
          FontAwesomeIcons.plus,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
