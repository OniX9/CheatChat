import 'package:cheat_chat/imports/imports.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = '/ProfileScreen';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? user;
  String? profilePicPath;

  TextEditingController nameController = TextEditingController();
  final utils = Utilities();
  final apiService = ApiService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initProvider();
    });
  }

  initProvider() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    user = userProvider.getUser;
      if (user != null) {
        populateFields(user!);
        // formatPhoneNumber(user!);
      }
  }

  void populateFields(UserModel user) {
    nameController.text = user.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    user = userProvider.getUser;
    if (user == null) {
      return LoadingScreen();
    }
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: kAppBlack,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileHeader(
              profileUrl: user?.profileUrl,
              selectedImagePath: profilePicPath,
              onSelectImage: () async {
                profilePicPath = await imagesPicker();
                setState(() {});
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Full name',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: kAppBlack),
                ),
                SizedBox(height: 5),
                CustomTextField(
                  hintText: 'Theresa Webb',
                  controller: nameController,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.green[900],
                  ),
                ),
                ButtonFilled(
                  text: "Update Profile",
                  onPressed: updateUser,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  updateUser() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    utils.showLoadingScreen(context);
    await userProvider.apiUpdateUser(
      context,
      name: nameController.text,
      profilePicPath: profilePicPath,
    ).then((updatedUser) {
      if (updatedUser != null) {
        utils.displayToastMessage(context, 'User profile updated successfully',
            backgroundColor: Colors.green);
      }
    });
    utils.dialogPopper(context);
  }
}

// ***SCREEN-ONLY WIDGETS***
// 1.
class ProfileHeader extends StatelessWidget {
  final String? profileUrl;
  final String? selectedImagePath;
  final Function()? onSelectImage;

  const ProfileHeader({
    super.key,
    this.profileUrl,
    this.onSelectImage,
    this.selectedImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, bottom: 25.0),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          GestureDetector(
            onTap: () {},
            child: selectedImagePath == null
                ? ProfileContainer(
                    radius: 90,
                    url: profileUrl,
                    placeholder: 'assets/images/profile_placeholder_mid.png',
                  )
                : CircleAvatar(
                    radius: 45,
                    backgroundImage: FileImage(File(selectedImagePath!)),
                  ),
          ),
          InkWell(
            onTap: onSelectImage,
            child: Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                'assets/svgs/edit_profile_icon.svg',
                width: 16,
                height: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future imagesPicker() async {
  final _picker = HLImagePicker();
  List<HLPickerItem>? res = await _picker.openPicker(
    pickerOptions: HLPickerOptions(
      mediaType: MediaType.image,
      maxSelectedAssets: 1,
      maxFileSize: 6000,
      enablePreview: true,
      convertHeicToJPG: true,
      thumbnailCompressQuality: 0.8,
      compressQuality: 0.4,
    ),
    cropOptions: HLCropOptions(
      aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 4),
      croppingStyle: CroppingStyle.circular,
    ),
  );

  return res[0].path;
}
