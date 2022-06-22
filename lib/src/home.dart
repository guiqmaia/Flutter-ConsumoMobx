// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter_mobx/flutter_mobx.dart';
import '../stores/consumo_list.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

final consumos = ConsumoList();


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double consumo = 0;

  void _handleConsumoField(String text){
    setState(() {
      if(text != ''){
        consumo = double.parse(text);
      }else{
        consumo = 0;
      }
    });
  }

  void _handleRegistrarButton (){
    if(consumo > 0){
      consumos.addConsumo(consumo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hello World'),
        ),
        body: Observer(
          builder: (_) => Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Qual foi o consumo da viagem?'
                ),
                keyboardType: TextInputType.number,
                onChanged: _handleConsumoField,
              ),
              RaisedButton(
                onPressed: _handleRegistrarButton,  
                child: Text('Registrar $consumo'),
                
              ),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text('Consumos Registrados:'),
                        Text('${consumos.list.length}')
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text('Consumo Médio Geral:'),
                        Text('${consumos.mediaConsumo}')
                      ],
                    ),
                  )
                ],
              ),

              Text('Registros:'),

              Container(
                height: 200,
                child: ListView.builder(
                  itemCount: consumos.list.length,
                  itemBuilder: (BuildContext ctx , int index){
                    return Text('- ${consumos.list[index]}');
                  },
                ),
              )

            ],
          ),
        ));
  }
}
