

import '../../../../core/network/error.dart';
import '../../../../core/utils/either.dart';

abstract class SetMPinUseCase {
  Future<Either<Failure,String>> call(String mPin);
}