class GlassGroupData {
  late Function changeState;

  List<GlassData> glasses = [
    GlassData(boardid: '35', glassid: '1', sliderValue: 0.0), GlassData(boardid: '35', glassid: '2', sliderValue: 0.0),
    GlassData(boardid: '35', glassid: '3', sliderValue: 0), GlassData(boardid: '35', glassid: '4', sliderValue: 0.0)
  ];
}


class GlassData {
  String boardid;
  String glassid;
  double sliderValue;
  GlassData({required this.boardid, required this.glassid, required this.sliderValue});
}

GlassGroupData myData = GlassGroupData();