





import '../../../libs.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController userName=TextEditingController();
  final TextEditingController password=TextEditingController();
  final FocusNode userNameFocus =FocusNode();
  final FocusNode passFocus =FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
     super.initState();
  }
  @override
  void dispose() {
   userName.dispose();
   password.dispose();
   userNameFocus.dispose();
   passFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return   SafeArea(
      child:  PopScope(
        canPop: false,
        onPopInvoked: (bool pop){
          if(pop)return;
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        },
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: customAppBar(
            title: ""
          ),

          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: 30,

                horizontal: 30
              ),
              child: Column(

                children: [


                  CustomTextApp(
                    text: "Sign In",
                    size: 30,
                    colors: AppColors.orange,
                    italic: true,
                  ).fullWidth(),
                  50.ph,
                  CustomTextField(
                    textEditingController: userName,
                    focusNode: userNameFocus,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    fillColor: AppColors.white,
                    hint: "User name",
                    validator:(String?value){
                      return checkEmpty(value);
                    } ,


                  ),
                  10.ph,

                  CustomTextField(
                    textEditingController: password,
                    focusNode: passFocus,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    suffixShowHidePassword: true,
                    fillColor: AppColors.white,
                    hint: "Password",
                    onFieldSubmitted: (String?value){
                      onSubmit();
                    },
                    validator: (String?value){
                      return checkEmpty(value);
                    },
                  ),
                  10.ph,

                  CustomButton(onPressed:onSubmit, text: "Sign In").fullWidth(),
                  10.ph,
                  CustomTextSpan(onPressed: () {
                  //Sign up screen

                  },
                    text1: "Don't have an account?",
                    text2:"Sign up" ,

                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
  void onSubmit()
  {
    if(_formKey.currentState!.validate())
    {
      sl<SignInProvider>().signInWithUserAndPassword(userName.text,
          password.text);
    }

  }
}
