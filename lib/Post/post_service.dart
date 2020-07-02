import 'dart:io';

import 'package:exception/Post/Failure.dart';
import 'package:exception/Post/post.dart';
import 'package:provider/provider.dart';

class FakeClientHttp{

  Future<String> getResponseBody() async{
    await Future.delayed(Duration(milliseconds: 500));
    //! No Internet Connection
     //throw SocketException('No Internet');
    //! 404
      throw HttpException('404');
    //! Invalid JSON (throws FormatException)
    // return 'abcd';

    return '{"userId":1,\n "id":1,\n "title":"nice title",\n "body":"cool body"}';
  }

}


class PostService{

  final httpClient=FakeClientHttp();


  Future<Post> getOnePost() async{

    try {
      final responseBody = await httpClient.getResponseBody();
      return Post.fromJson(responseBody);
    } on SocketException{
      print('Internet Failure');


    }on  HttpException{
      print('404');
    }on FormatException{
      print('Invalid Json');
    }catch(e){
      print(e.toString());
    }


  }

}