import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:practice_2/model/user_model.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';


class UserItem extends StatelessWidget {
  const UserItem({Key? key , this.model , this.onDelete}) : super(key: key);

  final UserDataModel? model;
  final Function? onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation:0,
      margin : const EdgeInsets.symmetric(horizontal: 10.0 , vertical: 5.0),
      child : Container ( 
          width :200,
          decoration : BoxDecoration(
            color:Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: userWidget(context),
        )
    );
  }

  Widget userWidget(context){
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model!.name!,
                  style : const TextStyle(
                    color:Colors.black,
                    fontWeight:FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height:10,

                ),
                Text(
                  model!.mobileno!,
                  style : const TextStyle(
                    color:Colors.black,
                    fontWeight:FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height:10,

                ),

                Text(
                  model!.email!,
                  style : const TextStyle(
                    color:Colors.black,
                    fontWeight:FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height:10,

                ),

                // Text(
                //   model!.password!,
                //   style : const TextStyle(
                //     color:Colors.black,
                //     fontWeight:FontWeight.bold,
                //   ),
                // ),
                // const SizedBox(
                //   height:10,

                // ),

                Text(
                  model!.userRole!,
                  style : const TextStyle(
                    color:Colors.black,
                    fontWeight:FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height:10,

                ),

                 Container(
                  width: MediaQuery.of(context).size.width - 180,
                  child : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        child: const Icon(Icons.edit),
                        onTap: (){
                          Navigator.of(context).pushNamed(
                            '/edit-user',
                            arguments: {'model':model}
                            );
                        },
                      ),
                      const SizedBox(
                        width:30,

                      ),
                       GestureDetector(
                        child: const Icon(Icons.delete , color: Colors.red),
                        onTap: (){
                          onDelete!(model!.id);
                        },
                      ),
                    ],
                  )
                )
              

              ],
              
            ),
          ),
        ],
      );
  }


}

