
import 'package:Azkar_Book/service/AzkarService.dart';

class AzkarProvider {
  final String code;
  // Stream<String> azkarFileContent = Stream<String>.periodic(Duration)

  Stream<String> get azkarContent async* {
    yield await AzkarService.getAzkarContent(this.code);
  }

  AzkarProvider(this.code) {
    // code = this.code;
    // print(this.code);
  }

}