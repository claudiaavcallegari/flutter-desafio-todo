import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/database/connection.dart';
import 'package:todo_list/app/database/database_adm_connection.dart';
import 'package:todo_list/app/modules/home/home_controller.dart';
import 'package:todo_list/app/modules/home/home_page.dart';
import 'package:todo_list/app/modules/new_task/new_task_controller.dart';
import 'package:todo_list/app/modules/new_task/new_task_page.dart';
import 'package:todo_list/app/repositories/todos_repository.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App>  {

DatabaseAdmConnection databaseAdmConnection = DatabaseAdmConnection();

@override
  void initState() {
    super.initState();
    Connection().instance;
    WidgetsBinding.instance.addObserver(databaseAdmConnection);
  }

  @override
    void dispose() {
      WidgetsBinding.instance.removeObserver(databaseAdmConnection);
      super.dispose();
    }

  

  @override
  Widget build(BuildContext context) {
    return MultiProvider (
      providers: [
        Provider(create: (_) => TodosRepository()),

      ],
      child: MaterialApp(
        title: 'Todo List',
        theme: ThemeData(
          primaryColor: Color(0xFFFF9129),
          buttonColor:  Color(0xFFFF9129),
          textTheme: GoogleFonts.robotoTextTheme(),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ChangeNotifierProvider(
          create: (context) {
           // antes da versão 4.1 do provider
           // var repository = Provider.of<TodosRepository>(context);

           // a partir da 4.1
            var repository = context.read<TodosRepository>();

          return HomeController(repository: repository);
          } ,
          child: HomePage(),
        
        ),
        routes: {
          NewTaskPage.routerName: (_) => ChangeNotifierProvider(
            create: (context){
              var day = ModalRoute.of(_).settings.arguments;
              return NewTaskController(repository: context.read<TodosRepository>(),day: day) ;
            } ,
            child: NewTaskPage(),)

        },
        
      ),
    );
  }
}

