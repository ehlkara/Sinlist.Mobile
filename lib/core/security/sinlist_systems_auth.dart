import 'package:flutter/material.dart';
import 'package:sinlist_app/core/http/response.dart';
import 'package:sinlist_app/core/utilities/constants.dart' as Constants;
import 'package:sinlist_app/core/security/base_auth.dart';

class SinlistSystemsAuth extends BaseAuth {
  SinlistSystemsAuth();
  BaseUser currentUserValue;

  @override
  Future<BaseUser> currentUser() {
    // TODO: implement currentUser
    throw UnimplementedError();
  }

  @override
  Future<Response> getUser(int id) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<Response> signIn(String number, String password) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

}