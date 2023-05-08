abstract class ToDoLoginState{}

class InitialLoginState extends ToDoLoginState{}

class ShowPassState extends ToDoLoginState{}

class ToDoLoginLoadingState extends ToDoLoginState{}

class ToDoLoginSuccessState extends ToDoLoginState{
  String uId;
  ToDoLoginSuccessState(this.uId);
}

class ToDoLoginErrorState extends ToDoLoginState{
  final String error;
  ToDoLoginErrorState(this.error);

}

class CreateUsersWithGoogleLoadingState extends ToDoLoginState{}
class CreateUsersWithGoogleSuccessState extends ToDoLoginState{}
class CreateUsersWithGoogleErrorState extends ToDoLoginState{
  final error;
  CreateUsersWithGoogleErrorState(this.error);
}