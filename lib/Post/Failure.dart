
import 'dart:io';

import 'package:exception/Post/post.dart';
import 'package:exception/Post/post_service.dart';
import 'package:flutter/cupertino.dart';

 class Failure {

  final Exception exception;

  Failure(this.exception);

  @override
  String toString() => exception.toString();
 }



enum NotifierState { initial, loading, loaded }


class PostChangeNotifier extends ChangeNotifier {
 final _postService = PostService();

 NotifierState _state = NotifierState.initial;
 NotifierState get state => _state;
 void _setState(NotifierState state) {
  _state = state;
  notifyListeners();
 }

 Post _post;
 Post get post => _post;
 void _setPost(Post post) {
  _post = post;
  notifyListeners();
 }

 Failure _failure;
 Failure get failure => _failure;
 void _setFailure(Failure failure) {
  _failure = failure;
  notifyListeners();
 }

 void getOnePost() async {
  _setState(NotifierState.loading);
  try {
   final post = await _postService.getOnePost();
   _setPost(post);
  }on HttpException{
   _setFailure(Failure(HttpException("404 NOT FOUND"),),);
  }on SocketException{
   _setFailure(Failure(SocketException("NO INTERNET")));
  }on FormatException{
   _setFailure(Failure((FormatException("Error While formating Json"))));
  }
  
  
 /* on Failure catch (f) {
   _setFailure(f);
  }*/
  _setState(NotifierState.loaded);
 }
}