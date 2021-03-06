import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:newsapp2/models/NewsModels.dart';

class NewsStates extends Equatable {
  const NewsStates();

  @override
  List<Object> get props => [];
}

class NewsInitState extends NewsStates {}

class NewsLoadingState extends NewsStates {}

class NewsLoadedState extends NewsStates {
  final List<Article> articleList;
  String code;
  NewsLoadedState({required this.articleList, required this.code});
}

class NewsErrorState extends NewsStates {
  final String errorMessage;
  NewsErrorState({required this.errorMessage});
}
