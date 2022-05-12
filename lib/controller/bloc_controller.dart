import 'dart:async';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

class BlocController{
   final _streamController = StreamController<String>.broadcast();
   Sink get searchcep => _streamController.sink;
   Stream<Map> get cepResult => _streamController.stream.switchMap(_searchCep);


   Stream<Map> _searchCep(String cep) async*{

    try{
      var result = await Dio().get('https://viacep.com.br/ws/$cep/json/');
      yield result.data as Map;

    }catch(e){
      yield* Stream.error(Exception('Erro na pesquisa'));
      throw Exception('erro');

    }
    
  }

  void dispose() {
    _streamController.close();
  }
}