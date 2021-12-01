import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeStates extends Equatable {
  final ThemeData theme;
  const ThemeStates({required this.theme});

  @override
  List<Object> get props => [theme];
}
