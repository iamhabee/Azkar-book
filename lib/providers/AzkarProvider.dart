
import 'package:Azkar_Book/service/AzkarService.dart';

class AzkarProvider {
  
  // Stream<String> azkarFileContent = Stream<String>.periodic(Duration)

  Stream<String> get azkarContent async* {
    yield await AzkarService.getAzkarContent();
  }

}