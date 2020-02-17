
import 'package:Azkar_Book/models/AdhkarModel.dart';
import 'package:Azkar_Book/service/AzkarService.dart';

class AzkarProvider {
  final String code;
  // Stream<String> azkarFileContent = Stream<String>.periodic(Duration)

  Stream<String> get azkarContent => Stream.fromFuture(AzkarService.getAzkarContent(this.code));

  Stream<List<Adhkar>> filteredCollection({searchParam}) =>
    Stream.fromFuture(AzkarService.getAdhkarList(q: searchParam));

  AzkarProvider({this.code});

}