import "package:flutter/material.dart";
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:monney_management/const_value.dart';
import 'package:monney_management/models/user.dart';
import 'package:monney_management/services/database.dart';
import 'package:quickalert/quickalert.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File ? _selectedImage;
  String? name,fullname;
  final nameEditingController=TextEditingController();
  final fullnameEditingController=TextEditingController();
  String? imagePath;
  final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final double heightR=MediaQuery.of(context).size.height;
    final user=Provider.of<MyUser?>(context);
    return Container(
      height: heightR/1.5,
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        border: Border.all(color: Colors.black),
        borderRadius: const BorderRadius.only(topRight:Radius.circular(40),topLeft:Radius.circular(40)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            imageProfile(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:20,horizontal:20),
              child: TextFormField(
                validator:(val){
                  if(val==null||val.isEmpty){
                    return "Enter your fullname";
                  }
                  else {
                    return null;
                  }
                },
                decoration: ConstWigdet().inputDecoration("Your full name"),
                onChanged:(text){
                  setState(() {
                    fullname=text;
                  });
                },
                controller: fullnameEditingController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:20,horizontal: 20),
              child: TextFormField(
                validator:(val){
                  if(val==null||val.isEmpty){
                    return "Enter your name";
                  }
                  else {
                    return null;
                  }
                },
                decoration: ConstWigdet().inputDecoration("Your name"),
                onChanged:(text){
                  setState(() {
                    name=text;
                  });
                },
                controller: nameEditingController,
              ),
            ),
            Container(
              height: 40,
              width: 120,
              decoration:BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(40),
                border:Border.all(color: Colors.black,width: 2.0)
              ),
              child: TextButton(
                onPressed:(){
                  imagePath=_selectedImage?.path;
                  Database(uid: user!.uid).updateData(name, fullname,imagePath);
                  Navigator.pop(context);
                },
                child: Text("Save",style: Font().bodyWhite,),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget imageProfile(){
    return Center(
      child: Stack(
        children: [
          imagePath!=null?CircleAvatar(
            radius: 40,
            backgroundImage: FileImage(File(imagePath!)),
          ):CircleAvatar(
            radius:40.0,
            backgroundImage:_selectedImage==null?const AssetImage('assets/images/napping.png'):FileImage(File(_selectedImage!.path))as ImageProvider ,
            backgroundColor: Colors.white,
          ),
          Positioned(
            top:60,
            left:50,
            child: InkWell(
              onTap: (){
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.info,
                  title: 'Choose Profile photo',
                  titleColor: Colors.black,
                  confirmBtnText:"Camera",
                  showCancelBtn: true,
                  cancelBtnText: "Gallery",
                  confirmBtnColor: Colors.orange.shade100,
                  confirmBtnTextStyle:Font().bodyBlack,
                  cancelBtnTextStyle: Font().bodyBlack,
                  onCancelBtnTap: _pickImageFromGallery,
                  onConfirmBtnTap: _pickImageFromCamera,
                );
              },
              child: const Icon(
                Icons.camera_alt,
                size: 25,
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),
    );
  }
  Future _pickImageFromGallery()async{
    final returnedImage= await ImagePicker().pickImage(source: ImageSource.gallery);
    if(returnedImage == null)return;
    setState(() {
      _selectedImage=File(returnedImage.path);
    });
  }
  Future _pickImageFromCamera()async{
    var returnedImage= await ImagePicker().pickImage(source: ImageSource.camera);
    if(returnedImage == null)return;
    setState(() {
      _selectedImage=File(returnedImage.path);
    });
  }
}
