import 'dart:async';
import 'dart:io';
import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quan_ly_ban_hang/data/models/personnel.dart';
import 'package:quan_ly_ban_hang/data/models/select_option_item.dart';
import 'package:quan_ly_ban_hang/data/models/user.dart';
import 'package:quan_ly_ban_hang/data/repositories/imgur_repo.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/appwrite_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/personnel_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/mixin/user_mixin.dart';
import 'package:quan_ly_ban_hang/share_function/share_funciton.dart';
import 'package:quan_ly_ban_hang/widgets/build_toast.dart';
import 'package:uuid/uuid.dart';

class AccountDetailController extends GetxController
    with
        GetTickerProviderStateMixin,
        StateMixin,
        UserMixin,
        AppWriteMixin,
        PersonnelMixin {
  final formKey = GlobalKey<FormState>();

  ImgurRepo imgurRepo = ImgurRepo();
  late TextEditingController? phoneTE,
      birtTE,
      addressTE,
      departmentTE,
      permissionTE,
      genderTE,
      nameTE,
      // ignore: non_constant_identifier_names
      CCCDTE;
  User? user;
  User? userLogin;
  String? avatar;
  DateTime? birthday;
  bool isResetPassword = false;
  var uuid = const Uuid();

  List<SelectOptionItem>? listDepartment = [];
  SelectOptionItem? departmentItemSelect;
  List<SelectOptionItem> listGender = [
    SelectOptionItem(key: 'Nam', value: 'Nam', data: null),
    SelectOptionItem(key: 'Nữ', value: 'Nữ', data: null),
  ];
  SelectOptionItem? genderItemSelect;
  List<SelectOptionItem>? listPermission = [];
  List<SelectOptionItem>? listPermissionSelect = [];

  var arguments = Get.arguments;
  @override
  Future<void> onInit() async {
    super.onInit();
    userLogin = getUserInBox();
    await initDataList();
    // loadingUI();
    // if (arguments != null) {
    //   if (arguments?['type'] == 'view') {
    //     await initDataList();
    //     getDataUser(id: arguments['personnelID']);
    //   }
    //   if (Get.arguments?['type'] == 'create') {
    //     await initDataList();
    //     initData();
    //   }
    // } else {
    //   // initData(user: userLogin);
    //   await getDataUser();
    // }

    // await initData();
    // await getDataUser();
    changeUI();
  }

// lấy ds list data
  initDataList() async {
    // loadingUI();
    var listDepartmentRequest = await getListDepartmentMixin();
    var listPermissionRequest = await getListPermissionMixin();
    listDepartment = listDepartmentRequest
        ?.map((e) => SelectOptionItem(key: e.name, value: e.code, data: e))
        .toList();
    listPermission = listPermissionRequest
        ?.map((e) => SelectOptionItem(key: e.name, value: e.code, data: e))
        .toList();
    // changeUI();
  }

  getDataUser({String? id}) async {
    loadingUI();
    if (id != null) {
      Personnel? personnel = await getDetailPersonnelMixin(id: id);
      user = User(
          uId: personnel?.uId,
          name: personnel?.name,
          phone: personnel?.phone,
          cccd: personnel?.cccd,
          address: personnel?.address,
          birthday: personnel?.birthday.toString(),
          gender: personnel?.gender,
          department: personnel?.department,
          permission: personnel?.permission,
          password: personnel?.password,
          resetPassword: personnel?.resetPassword,
          avatar: personnel?.avatar,
          $collectionId: personnel?.collectionId,
          $databaseId: personnel?.databaseId,
          $id: personnel?.id,
          $createdAt: personnel?.createdAt,
          $updatedAt: personnel?.updatedAt);
      await initData(user: user);
      await initDataList();
      setValueSelect(user);
      changeUI();
    } else {
      user = getUserInBox();
      await initData(user: user);
      changeUI();
    }

    // updateUI();
    // changeUI();
  }

  initData({User? user}) {
    phoneTE = TextEditingController(text: user?.phone);
    birtTE = TextEditingController(
        text: ShareFuntion.formatDate(
            type: TypeDate.ddMMyyyy,
            dateTime: user?.birthday != null
                ? DateTime.parse(user!.birthday!.toString())
                : DateTime.now()));
    addressTE = TextEditingController(text: user?.address);
    nameTE = TextEditingController(text: user?.name);
    CCCDTE = TextEditingController(text: user?.cccd);
    String? y = listDepartment
        ?.where((element) => user?.department == element.value)
        .firstOrNull
        ?.key;
    departmentTE =
        TextEditingController(text: y?.toUpperCase() ?? user?.department);
    genderTE = TextEditingController(text: user?.gender);
    String x = '';
    user?.permission?.forEach((element) {
      x = '$x,$element';
    });
    permissionTE = TextEditingController(text: x);
    avatar = user?.avatar;
    birthday = DateTime.parse(user?.birthday ?? DateTime.now().toString());
    departmentItemSelect = null;
    genderItemSelect = null;
    listPermissionSelect = [];
    update();
    changeUI();
  }

  setValueSelect(User? user) {
    departmentItemSelect = listDepartment
        ?.where((element) => user?.department == element.value)
        .firstOrNull;
    genderItemSelect = listGender
        .where((element) => user?.gender == element.value)
        .firstOrNull;
    listPermissionSelect = listPermission
        ?.where((element) => user?.permission?.contains(element.value) ?? false)
        .toList();

    updateDataTextEditing();
  }

  updateDataTextEditing() {
    departmentTE =
        TextEditingController(text: departmentItemSelect?.key?.toUpperCase());
    genderTE = TextEditingController(text: genderItemSelect?.value);
    String x = '';
    listPermissionSelect?.forEach((element) {
      x = '$x,${element.value}';
    });
    
    permissionTE = TextEditingController(text: x);
    birtTE = TextEditingController(
        text: ShareFuntion.formatDate(
            type: TypeDate.ddMMyyyy,
            dateTime: birthday != null
                ? DateTime.parse(birthday!.toString())
                : null));

    update();
  }

  Future<void> setAvatar() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    uploadImageWithImgur(File(image!.path));
  }

// tải ảnh lên imgur
  uploadImageWithImgur(File file) async {
    loadingUI();
    var res = await imgurRepo.upLoadImageImgur(file);
    avatar = res?["link"];
    changeUI();
  }

// cập nhật - có cập nhật ng dùng trong box k
  Future<void> updateUser({bool isUpdateUserLogin = false}) async {
    loadingUI();
    List<Personnel>? listCheck = await checkUniquePersonnelMixin(
        cccd: CCCDTE?.text, phone: phoneTE?.text);

// kiểm tra sdt đã tồn tại hay chưa, nếu tồn tại phải 2 id bằng nhau mới cho sửa
    if ((listCheck == null || listCheck.length <= 1) &&
        ((listCheck?.length ?? 0) < 1
            ? listCheck?.firstOrNull?.uId != user?.uId
            : listCheck?.firstOrNull?.uId == user?.uId)) {
      user = await updateDetailUserMixin(
          user: user?.copyWith(
              avatar: avatar,
              phone: phoneTE?.text,
              name: nameTE?.text,
              birthday: birthday.toString(),
              address: addressTE?.text,
              cccd: CCCDTE?.text,
              resetPassword: isResetPassword,
              password: isResetPassword ? '12345678' : null,
              permission:
                  listPermissionSelect?.map((e) => e.value ?? '').toList(),
              department: departmentItemSelect?.value,
              gender: genderItemSelect?.value),
          isUpdateUserLogin: isUpdateUserLogin,
          id: user?.$id);
    } else {
      buildToast(
          message: 'CCCD hoặc số điện thoại đã tồn tại trong hệ thống',
          status: TypeToast.getError);
    }
    changeUI();
  }

// tạo ng dùng
  createPersonnel() async {
    loadingUI();
    if (nameTE?.text == null ||
        nameTE?.text == '' ||
        phoneTE?.text == null ||
        phoneTE?.text == '' ||
        CCCDTE?.text == null ||
        CCCDTE?.text == '' ||
        genderTE?.text == null ||
        genderTE?.text == '' ||
        birtTE?.text == null ||
        birtTE?.text == '' ||
        addressTE?.text == null ||
        addressTE?.text == '' ||
        departmentTE?.text == null ||
        departmentTE?.text == '') {
      buildToast(
          message: 'Không để trống dữ liệu: tên, sdt, chức vụ,...',
          status: TypeToast.toastError);
      changeUI();
      return;
    } else {
      List<Personnel>? listCheck = await checkUniquePersonnelMixin(
          cccd: CCCDTE?.text, phone: phoneTE?.text);

      if ((listCheck == null || listCheck.isEmpty)) {
        var result = await createDetailPersonnelMixin(
            personnel: Personnel(
                uId: uuid.v4(),
                name: nameTE?.text,
                phone: phoneTE?.text,
                cccd: CCCDTE?.text,
                gender: genderTE?.text,
                birthday: birthday.toString(),
                address: addressTE?.text,
                resetPassword: true,
                password: '12345678',
                department: departmentTE?.text,
                avatar: avatar));
        changeUI();
        if (result != null) {
          initData();
        }
      } else {
        buildToast(
            message: 'CCCD hoặc số điện thoại đã tồn tại trong hệ thống',
            status: TypeToast.getError);
      }
    }
    changeUI();
  }

  logout() async {
    await ShareFuntion.onPopDialog(
        context: Get.context!,
        title: 'Bạn muốn đăng xuất?',
        onCancel: () {
          Get.back();
        },
        onSubmit: () async {
          await clearDataUser();
          await clearAndResetApp();
          // Get.offAndToNamed(SplashScreen.routeName);
        });
  }

  String? validateString(String? text) {
    if (text == null || text.isEmpty) {
      return "Trường bắt buộc";
    }
    return null;
  }

  String? numberValidator(String? value) {
    if (value == null || value == '') {
      return null;
    }
    final n = num.tryParse(value);
    if (n == null) {
      return '$value không phải kiểu số';
    }
    return null;
  }

  changeUI() {
    change(null, status: RxStatus.success());
  }

  updateUI() {
    update();
  }

  loadingUI() {
    change(null, status: RxStatus.loading());
  }
}
