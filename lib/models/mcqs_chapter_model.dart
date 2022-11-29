
class McqsChapterModel{
  String chapterName;

 McqsChapterModel({required this.chapterName}); 

factory McqsChapterModel.fromJson(Map<String,dynamic>json){
  return McqsChapterModel(chapterName: json['Chapter']);}
}     