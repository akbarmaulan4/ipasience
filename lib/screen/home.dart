import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:materi_ipa/bloc/auth_bloc.dart';
import 'package:materi_ipa/model/kelas/kelas_model.dart';
import 'package:materi_ipa/model/subject/subject_model.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthBloc bloc = AuthBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.setDefaultKelas();

    bloc.subjectsDetail.listen((event) {
      if(event != null){
        Navigator.pushNamed(context, '/pdf', arguments: {'url':bloc.baseUrl, 'fileName':event.file_name});
      }
    });
    // bloc.getSubjects();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          children: [
            StreamBuilder(
                stream: bloc.dataKelas,
                builder: (context, snapshot) {
                  List<KelasModel> dataKelas = [];
                  if(snapshot.data != null){
                    dataKelas = snapshot.data as List<KelasModel>;
                  }
                  return StreamBuilder(
                    stream: bloc.selectedClass,
                    builder: (context, snapshot) {
                      KelasModel selected = bloc.selectedKelas;
                      if(snapshot.data != null){
                        selected = snapshot.data as KelasModel;
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                color: Colors.grey.shade200
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            width: double.infinity,
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: Text('Pilih Kelas'),
                                  // value: bloc.strSort,
                                  value: selected,
                                  items: dataKelas.map((value) {
                                    return DropdownMenuItem(
                                      child: Container(
                                          margin: EdgeInsets.symmetric(horizontal: 10),
                                          child: Text(value.name)),
                                      value: value,
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    bloc.changeClass(value as KelasModel);
                                  },
                                )
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            child: Text(selected.name == 'Pilih Kelas' ? 'Silahan Pilih kelas untuk melihat materi pembelajaran':
                            'Materi Pembelajaran ${selected.name}', style: GoogleFonts.alike(fontSize: 18),),
                          )
                        ],
                      );
                    }
                  );
                }
            ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder(
                stream: bloc.subjects,
                builder: (context, snapshot) {
                  List<SubjectModel> dataSubject = [];
                  if(snapshot.data != null){
                    dataSubject = snapshot.data as List<SubjectModel>;
                  }
                  return Container(
                    child: ListView.builder(
                      itemCount: dataSubject.length,
                      itemBuilder: (context, index){
                        return InkWell(
                          onTap: ()=>bloc.getDetailSubject(dataSubject[index].id.toString()),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            child: Row(
                              children: [
                                Text('${(index + 1)}.', style: GoogleFonts.alike(fontSize: 15),),
                                SizedBox(width: 5,),
                                Text(dataSubject[index].name, style: GoogleFonts.alike(fontSize: 15))
                              ],
                            ),
                          ),
                        );
                        // return ListTile(
                        //   contentPadding: EdgeInsets.all(0),
                        //   // leading: Text('${(index + 1)}'),
                        //   title: Text(dataSubject[index].name),
                        // );
                      },
                    ),
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
