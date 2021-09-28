
import 'package:equatable/equatable.dart';

class GrumblerUser extends Equatable
{
  final String name;
  final String? lastName;
  final String? avatarUrl;
  final String email;
  final String uid;

  const GrumblerUser({required this.name, this.lastName, this.avatarUrl, required this.email, required this.uid});

  @override
  List<Object?> get props =>[uid];

}