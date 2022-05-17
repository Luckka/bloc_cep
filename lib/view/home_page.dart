import 'package:bloc_flutter/controller/bloc_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController textEditingController = TextEditingController();

  BlocController blocController = BlocController();
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ZipCode',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).primaryColorDark,
                    Theme.of(context).primaryColorLight
                  ]
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0,0),
                    spreadRadius: 0,
                    blurRadius: 4,
                    color: Colors.black
                  )
                ],
                borderRadius: BorderRadius.only(bottomLeft:Radius.circular(80) )
              ),


              child:Image(image: AssetImage('assets/icon/search.png')),

            ),
            SizedBox(height: 20,),

            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: textEditingController,
                  decoration: InputDecoration(
                    labelText: 'Cep',
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    icon: Icon(Icons.search)
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                  blocController.searchcep.add(textEditingController.text);
                }, child: Text('Enviar')),
                SizedBox(height: 20,),

                StreamBuilder<SearchCepState>(
                  stream: blocController.cepResult,
                  builder: (context,snapshot){
                    
                    var state = snapshot.data;
                    if(!snapshot.hasData){
                      return Container();
                    }

                    if(state is SearchCepError){
                      return Text('${snapshot.error}',style: TextStyle(color: Colors.red),);
                    }

                    if(state is SearchCepLoading){
                      return Container(child:CircularProgressIndicator(),);
                    }
                     state = state as SearchCepSucess;
                    return Text('Cidade: ${state.data['localidade']}');
                  })
                ]
              ),
            )
          ],
        ),
      )
    );
  }
}