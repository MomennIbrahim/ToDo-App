abstract class ToDoRegisterState{}

class InitialTodoRegisterState extends ToDoRegisterState{}

class RegisterLoadingState extends ToDoRegisterState{}
class RegisterSuccessState extends ToDoRegisterState{}
class RegisterErrorState extends ToDoRegisterState{
  final String error;

  RegisterErrorState(this.error);
}

class CreateUsersLoadingState extends ToDoRegisterState{}
class CreateUsersSuccessState extends ToDoRegisterState{}
class CreateUsersErrorState extends ToDoRegisterState{
  final error;
  CreateUsersErrorState(this.error);
}