import 'package:dartz/dartz.dart';
import 'package:weather_app_clean_architecture/core/failures/failures.dart';

abstract class UseCase<Type, Params>{
  Future<Either<Failure, Type>> call(Params params);
}

