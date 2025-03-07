import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/Features/profile/data/models/Get_user_profile_response.dart';
import 'package:online_exam_app/Features/profile/data/models/edit_profile_request.dart';
import 'package:online_exam_app/Features/profile/presentation/manager/profile_cubit.dart';
import 'package:online_exam_app/Features/profile/presentation/manager/profile_states.dart';
import 'package:online_exam_app/Features/profile/presentation/pages/change_password_page.dart';
import 'package:online_exam_app/core/Constant/app_constant.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/core/routes/app_routes.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';

import '../../../../core/base_states/base_states.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = getIt<ProfileCubit>()..getUserProfile();
    UserProfile userProfile=UserProfile();
    EditProfileRequest editProfileRequest=EditProfileRequest();
    profileCubit.userNameController.text = userProfile.username ?? '';
    profileCubit.firstNameController.text = userProfile.firstName ?? '';
    profileCubit.lastNameController.text = userProfile.lastName ?? '';
    profileCubit.emailController.text = userProfile.email ?? '';
    profileCubit.phoneNumberController.text = userProfile.phone ?? '';
    return BlocProvider(
      create: (context) => profileCubit,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Profile'),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
            ),
            BlocConsumer<ProfileCubit,ProfileStates>(
              listener: (context, state) {

                if (state.editProfile is SuccessState) {
                  Navigator.pushReplacementNamed(
                      context, AppRoutes.layoutScreen);
                } else if (state.editProfile is ErrorState) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text((state.editProfile as ErrorState).error?? ""),
                      );
                    },
                  );
                } else if (state.editProfile is LoadingState) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) =>
                    const Center(child: CircularProgressIndicator()),
                  );
                }
              },
              builder: (context, state) {

                return SliverPadding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate.fixed(
                      [
                        Form(
                          key: profileCubit.profileFormKey,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                      radius: 75.r,
                                      backgroundColor: AppColors.blue,
                                      child: Icon(
                                        Icons.person,
                                        size: 100.w,
                                        color: Colors.white,
                                      )),
                                  Positioned(child:  CircleAvatar(
                                      radius: 25.r,
                                      backgroundColor: AppColors.white,
                                      child: IconButton(
                                      icon:  Icon(
                                          Icons.camera_alt,
                                          size: 30.w,
                                          color: AppColors.blue,
                                        ),onPressed: () {

                                        },
                                      )),bottom: 0,right: 0,)
                                ],
                              ),
                              SizedBox(height: 40.h,),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "User Name is required";
                                  }
                                  if(value!=userProfile.username){
                                    editProfileRequest.userName=profileCubit.userNameController.text;

                                  }
                                  return null;
                                },

                                controller: profileCubit.userNameController,
                                decoration: const InputDecoration(

                                    hintText: 'Enter Your User Name',
                                    labelText: 'User Name'),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 163.w,
                                    height: 56.h,
                                    child: TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Required";
                                          }
                                          if(value!=userProfile.firstName){
                                            editProfileRequest.firstName=profileCubit.firstNameController.text;
                                          }
                                          return null;
                                        },
                                        controller:
                                        profileCubit.firstNameController,

                                        decoration: const InputDecoration(
                                            hintText: 'Enter First Name',
                                            labelText: 'First Name')),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                      width: 163.w,
                                      height: 56.h,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Required";
                                          }
                                          if(value!=userProfile.lastName){
                                            editProfileRequest.lastName=profileCubit.lastNameController.text;
                                          }
                                          return null;
                                        },
                                        controller:
                                        profileCubit.lastNameController,
                                        decoration: const InputDecoration(
                                          hintText: 'Enter Last Name',
                                          labelText: 'Last Name',
                                        ),
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Email is required";
                                    } else if (!AppConstant.emailRegex
                                        .hasMatch(value)) {
                                      return "Enter Valid Email";
                                    }
                                    if(value!=userProfile.email){
                                      editProfileRequest.email=profileCubit.emailController.text;
                                    }
                                    return null;
                                  },
                                  controller: profileCubit.emailController,
                                  decoration: const InputDecoration(
                                      hintText: 'Enter Email',
                                      labelText: 'Email')),
                              SizedBox(
                                height: 16.h,
                              ),
                              SizedBox(

                                child: Stack(
                                  children: [
                                    TextFormField(
                                                                 readOnly: true,
                                      controller: profileCubit.passwordController,
                                      decoration:  InputDecoration(
                                          hintText: 'Enter Password',
                                          prefixIcon: Padding(
                                            padding:  EdgeInsets.only(left: 12.w),
                                            child: Row(
                                              children: [
                                                Icon(Icons.star,size: 20.w,color: AppColors.gray,),
                                                Icon(Icons.star,size: 20.w,color: AppColors.gray,),
                                                Icon(Icons.star,size: 20.w,color: AppColors.gray,),
                                                Icon(Icons.star,size: 20.w,color: AppColors.gray,),
                                                Icon(Icons.star,size: 20.w,color: AppColors.gray,),
                                                Icon(Icons.star,size: 20.w,color: AppColors.gray,),

                                              ],
                                            ),
                                          ),

                                        ),
                                    ),
                                    Positioned(right: 0,
                                      child: TextButton(onPressed: () {

Navigator.of(context).push(MaterialPageRoute(builder: (context) {
return  ChangePasswordPage();
},));
                                      }, child: Text("change")),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Phone Is Required";
                                  } else if (!AppConstant.phoneRegex
                                      .hasMatch(value)) {
                                    return "Enter Valid Phone";
                                  }     if(value!=userProfile.phone){
                                    editProfileRequest.phone=profileCubit.phoneNumberController.text;
                                  }
                                  return null;
                                },
                                controller: profileCubit.phoneNumberController,
                                decoration: const InputDecoration(
                                    hintText: 'Enter Phone Number',
                                    labelText: 'Phone Number'),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (profileCubit.profileFormKey.currentState!
                                      .validate()) {
                                    profileCubit.editProfile(editProfileRequest);
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0.r),
                                      child: const Text('Update'),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}