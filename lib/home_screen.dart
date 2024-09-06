import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeState();

}
class HomeState extends State<HomeScreen>{
  final TextEditingController _glassNoTEController = TextEditingController(
      text: '1'
  );

  List<WaterTrack> waterTracker =[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: Text('Water tracker',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, right: 12, left: 12),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(getTotalGlassCount().toString(),style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold
                ),),
                Text('Glass/s',style: TextStyle(
                  fontSize: 22,
                ),),
              ],
            ),
            SizedBox(height: 10,),
            Center(
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 10,
                child: Container(
                  height: 220,
                  width: 370,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: TextButton(
                              onPressed: _addNewWaterTrack,
                              child: Text('Tap',
                                style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold
                              ),),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 150,
                          child: TextField(
                            controller: _glassNoTEController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              label: Text('Number'),
                              labelStyle: TextStyle(
                                color: Colors.grey
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.blueAccent,
                                  width: 2,
                                )
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Colors.blueAccent,
                                    width: 2,
                                  )
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Expanded(
                child: ListView.separated(
                  itemCount: waterTracker.length,
                    itemBuilder: (context,index){
                    final WaterTrack waterTrack = waterTracker[index];
                      return Card(
                        elevation: 4,
                        child: ListTile(
                          title: Text('${waterTrack.dateTime.hour} :${waterTrack.dateTime.minute}'),
                          subtitle: Text('${waterTrack.dateTime.day}/ ${waterTrack.dateTime.month}/ ${waterTrack.dateTime.year}'),
                          leading: CircleAvatar(child: Text('${waterTrack.noOfGlasses}')),
                          trailing: IconButton(onPressed:() => _onTapDeleteButton(index), icon: Icon(Icons.delete,color: Colors.blueAccent,size: 30,)),
                        ),
                      );
                      },
                    separatorBuilder: (context,index){
                      return SizedBox(height: 3);
                    }, 
                )
            )
          ],
        ),
      ),
    );
  }
  int getTotalGlassCount(){
    int counter = 0;
    for(WaterTrack t in waterTracker){
      counter += t.noOfGlasses;
    }
    return counter;
  }
  void _addNewWaterTrack(){
    if(_glassNoTEController.text.isEmpty){
      _glassNoTEController.text = '1';
    }
    final int noOfGlasses = int.tryParse(_glassNoTEController.text) ?? 1;
    WaterTrack waterTrack = WaterTrack(noOfGlasses: noOfGlasses, dateTime: DateTime.now());
    waterTracker.add(waterTrack);
    setState(() {});
  }
  void _onTapDeleteButton(int index){
    waterTracker.removeAt(index);
    setState(() {});
  }
  void dispose(){
    _glassNoTEController.dispose();
    super.dispose();
  }
}

class WaterTrack{
  final int noOfGlasses;
  final DateTime dateTime;

  WaterTrack({required this.noOfGlasses, required this.dateTime});
}