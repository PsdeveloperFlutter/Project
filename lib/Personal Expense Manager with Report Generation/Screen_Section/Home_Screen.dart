import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled/Personal%20Expense%20Manager%20with%20Report%20Generation/Database_section/Database_Month_Expense_.dart';
import 'package:untitled/Personal%20Expense%20Manager%20with%20Report%20Generation/Database_section/Fl_chart_representation.dart';
import '../Database_section/Database_part.dart';

// ----------------------------------------------------------------//
//It is VERY IMPORTANT that you have a database file named 'expense.db'//
// ----------------------------------------------------------------//
//IT IS VERY IMPORTANT FOR SHOWING THE DATA OF MONTH AND YEAR
Rx<dynamic>showyearandmonth = true.obs; //If it is true so it shows the year anotherwise month

// Theme Controller for Dark/Light Mode
class ThemeController extends GetxController {
  // Observable theme mode
  var isDarkMode = false.obs;

  // Toggle theme mode
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}

// Main Screen
class ExpensesScreen extends StatefulWidget {
  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final ExpensesController controller = Get.put(ExpensesController()); //It is for the controller that of years
  final MonthlyExpensesController controllermonth = Get.put(MonthlyExpensesController()); //It is for the controller that of months

  final ThemeController themeController = Get.put(ThemeController());

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon:InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        width: 400,
                        height: 400, // Set the desired height of the dialog box
                        child: AlertDialog(
                          title: const Text('Settings',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          content: const Text('Set currency ',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700),),
                          actions: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('USD'),
                                  ),
                                  const Gap(40,),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('EUR'),
                                  ),
                                ],
                              ),
                            ),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Gap(30),
                                const Text('Select Options',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700),),
                                const Gap(10),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {

                                          setState(() {
                                            showyearandmonth.value=false;
                                                   Navigator.pop(context);
                                          });

                                        },
                                        child: const Text('Month',style: TextStyle(fontSize: 12),),
                                      ),
                                      const Gap(40,),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            showyearandmonth.value=true;
                                            Navigator.pop(context);
                                          });
                                          },
                                        child: const Text('Year',style: TextStyle(fontSize: 12),
                                      ),
                                      ),],
                                  ),
                                ),
                              ]
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
                child: const Icon(CupertinoIcons.settings_solid),
              ),

              label: 'Setting',
            ),
          ],
            currentIndex: _selectedIndex,
            iconSize: 25,// Adjust the size of the icons,
            onTap: _onItemTapped,
        ),
        appBar: AppBar(
          backgroundColor: themeController.isDarkMode.value
              ? Colors.grey.shade900
              : Colors.blue.shade500,
          centerTitle: true,
          title: const Text('Expenses'),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'Toggle Theme') {
                  themeController.toggleTheme();
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'Toggle Theme',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dark Mode',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Divider(),
                        Text('Light Mode'),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
        body: Obx((){
          return ListView.builder(
            itemCount: showyearandmonth ==true ? controller.expenses.length : controllermonth.expenses.length,
            itemBuilder: (context, index) {
              var expense =  showyearandmonth ==true ? controller.expenses[index] : controllermonth.expenses[index];
              return Dismissible(
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                secondaryBackground: Container(
                  color: Colors.green,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.edit, color: Colors.white),
                ),
                key: UniqueKey(),
                onDismissed: (_) => showyearandmonth ==true ? controller.deleteExpense(controller.expenses[index].id!): controllermonth.deleteExpense(controllermonth.expenses[index].id!),
                child: Card(
                  elevation: 4,
                  child: ExpansionTile(
                    title: Text(
                      showyearandmonth ==true ? controller.expenses[index].category : controllermonth.expenses[index].category_month,
                      style: const TextStyle(fontFamily: 'Itim', fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          margin: const EdgeInsets.all(2),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(showyearandmonth ==true ? controller.expenses[index].description : controllermonth.expenses[index].description_month,),
                                subtitle: Text(
                                    '${showyearandmonth ==true ? controller.expenses[index].amount : controllermonth.expenses[index].amount_month
                                        .toStringAsFixed(2)} ${showyearandmonth ==true ? controller.expenses[index].category : controllermonth.expenses[index].category_month }'),
                                trailing: Text(showyearandmonth==true ? controller.expenses[index].date.toString() : "Month ${controllermonth.expenses[index].month_month.toString()} Year ${controllermonth.expenses[index].year_month.toString()}"),
                                onTap: () => showyearandmonth ==true ? controller.openBottomSheet(
                                  context,
                                  expense: expense as Expense,
                                ): controllermonth.openBottomSheet(context, expense: expense as MonthlyExpense),
                              ),

                              const Gap(5),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Gap(10),
                                      NeoPopButton(
                                        color: themeController.isDarkMode.value
                                            ? Colors.grey.shade800
                                            : Colors.blue.shade500,
                                        depth: 3,
                                        onTapUp: () {

                                          Navigator.push(context, MaterialPageRoute(builder: (context) => BarChartPage(storevalue: showyearandmonth ==true ? getthevalue(controller.expenses.length,controller.expenses):getthevalueformonth(controllermonth.expenses.length,controllermonth.expenses))));
                                          print("Generate chart");
                                        },

                                        border: Border.all(
                                            color: themeController.isDarkMode.value
                                                ? Colors.grey.shade700
                                                : Colors.blue.shade700,
                                            width: 1),
                                        child: const Text(
                                          "Generate a new report",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Itim'),
                                        ),
                                      ),
                                      const Gap(20),
                                      NeoPopButton(
                                        color: themeController.isDarkMode.value
                                            ? Colors.grey.shade800
                                            : Colors.blue.shade500,
                                        depth: 3,
                                        onTapUp: () {

                                          print("See Chart Report");
                                        },

                                        border: Border.all(
                                            color: themeController.isDarkMode.value
                                                ? Colors.grey.shade700
                                                : Colors.blue.shade700,
                                            width: 1),
                                        child: const Text(
                                          "Generate Pdf",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Itim'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Gap(5),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showyearandmonth ==true ? controller.openBottomSheet(context):controllermonth.openBottomSheet(context),
          child: const Icon(Icons.add),
        ),
      );
    });
  }

  // Method to build Shimmer effect
  Widget _buildShimmerEffect() {
    return ListView.builder(
      itemCount: 5, // Simulate 5 shimmer loading items
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 20.0,
                    color: Colors.white,
                  ),
                  const Gap(10),
                  Container(
                    width: 150.0,
                    height: 15.0,
                    color: Colors.white,
                  ),
                  const Gap(5),
                  Container(
                    width: 100.0,
                    height: 15.0,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //This is the default method
  RxList <dynamic>givethevalue(double amount, DateTime date, int index, var value) {
    RxList storevalues = [].obs;
    for (int i = 0; i <index; i++) {
      storevalues.add(value[i]);
    }
    return storevalues;
  }

  RxList<dynamic>getthevalue(int length, RxList<Expense> expenses) {
    RxList storevalues = [].obs;
    for (int i = 0; i < length; i++) {
      storevalues.add(expenses[i]);
    }
    return storevalues;
  }

  RxList<dynamic>getthevalueformonth(int length, RxList<MonthlyExpense> expenses) {
    RxList storevalues = [].obs;
    for (int i = 0; i < length; i++) {
      storevalues.add(expenses[i]);
    }
    return storevalues;
  }




}

// Main Function
void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(), // Default light theme
      darkTheme: ThemeData.dark(), // Dark theme
      themeMode: ThemeMode.light, // Initial theme mode
      home: ExpensesScreen(),
    ),
  );
}
