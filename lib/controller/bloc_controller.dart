import 'dart:async';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';


abstract class SearchCepState{

}

class SearchCepSucess implements SearchCepState{
  final Map data;

  const SearchCepSucess(this.data);
}

class SearchCepLoading implements SearchCepState{
  const SearchCepLoading();
}

class SearchCepError implements SearchCepState{
  final String message;

  const SearchCepError(this.message);

}

class BlocController{
   final _streamController = StreamController<String>.broadcast();
   Sink get searchcep => _streamController.sink;
   Stream<SearchCepState> get cepResult => _streamController.stream.switchMap(_searchCep);


   Stream<SearchCepState> _searchCep(String cep) async*{
    yield const SearchCepLoading();
    try{
      final response = await Dio().get('https://viacep.com.br/ws/$cep/json/');
      yield SearchCepSucess(response.data);

    }catch(e){
      yield const SearchCepError('Erro ao buscar cep');


    }
    
  }

  void dispose() {
    _streamController.close();
  }
}