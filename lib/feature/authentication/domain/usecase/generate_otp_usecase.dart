import '../../../../core/network/error.dart';
import '../../../../core/utils/either.dart';

abstract class GenerateOtpUseCase {
  Future<Either<Failure, String?>> call(String uId, String mobileNumber);
}
