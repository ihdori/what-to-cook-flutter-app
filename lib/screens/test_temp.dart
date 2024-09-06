import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:what2cooke/functions/random_choice.dart';
import 'package:what2cooke/providers/database_provider.dart';

class TestScreen extends ConsumerWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealData = ref.watch(databaseProvider);
    int n = 2;
    return Scaffold(
      body: mealData.when(data: (data) {
        return FutureBuilder(
            future: data.rawQuery('''
            SELECT * 
            FROM meals
            JOIN regions on regions.id = meals.region_id
            JOIN meal_time_relations on meal_time_relations.m_id = meal_id
            JOIN times on times.time_id = meal_time_relations.t_id
            WHERE regions.id = $n 
            AND meal_time_relations.t_id =3 
            ;
            '''),
            builder: (
              context,
              AsyncSnapshot<List<Map<String, Object?>>> snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Center(child: Text('${snapshot.data!.length}'));
              }
              return Text('0000');
            });
      }, loading: () {
        return Center(child: CircularProgressIndicator());
      }, error: (error, stackTrace) {
        print(error);
        return Center(child: Text('Error: $error'));
      }),
    );
  }
}


// FutureBuilder<List<Map<String, Object?>>>(
//                 future: data.database, // Fetch meals asynchronously
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return CircularProgressIndicator();
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return Center(child: Text('No meals found'));
//                   }

//                   // Data is available, display it
//                   final meals = snapshot.data!;
//                   return ListView.builder(
//                     itemCount: meals.length,
//                     itemBuilder: (context, index) {
//                       final meal = meals[index];
//                       return ListTile(
//                         title: Text(
//                             '${meal['meal_name']}, ${meal['region_id']}'), // Replace with your actual column name
//                         trailing:
//                             IconButton(onPressed: () {}, icon: Icon(Icons.abc)),
//                       );
//                     },
//                   );
//                 },
//               ),
