import 'package:auto_waste/model/post.dart';
import 'package:auto_waste/utils/uidata.dart';
class PostViewModel {
  List<Post> postItems;

  PostViewModel({this.postItems});

  getPosts() => <Post>[
        Post(
            personName: "Tinuke",
            address: "Oluyole",
            likesCount: 100,
            commentsCount: 10,
            message:
                "I would like to know if the silver app bar used is dynamic for both Material and Cupertino",
            personImage:
            UIData.user2,
            messageImage:
                UIData.logo,
            postTime: "Just Now"),
        Post(
            personName: "Amaka",
            address: "Bashorun",
            likesCount: 123,
            commentsCount: 78,
            messageImage:
                UIData.logo,
            message:
                "Nice one",
            personImage:
                UIData.user3,
            postTime: "5h ago"),
        Post(
            personName: "Aderonke",
            address: "Ikeja",
            likesCount: 50,
            commentsCount: 5,
            message:
                "How are we moving this forward",
            personImage:
                UIData.user4,
            postTime: "2h ago"),

      ];
}
