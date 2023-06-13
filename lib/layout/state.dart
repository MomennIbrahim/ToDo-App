abstract class ToDoStates{}

class InitialToDoState extends ToDoStates{}

class ChangeBottomNavBarState extends ToDoStates{}
class ChangeThemeState extends ToDoStates{}
class EnLangState extends ToDoStates{}
class ArLangState extends ToDoStates{}

class CreateToDoLoadingState extends ToDoStates{}
class CreateToDoSuccessState extends ToDoStates{

}
class CreateToDoErrorState extends ToDoStates{}

class GetToDoSuccessState extends ToDoStates{}
class GetToDoErrorState extends ToDoStates{}

class GetUserLoadingToDoState extends ToDoStates{}
class GetUserSuccessToDoState extends ToDoStates{}
class GetUserErrorToDoState extends ToDoStates{}

class GetToDoListSuccessState extends ToDoStates{
}

class ShowDatePickerSuccessState extends ToDoStates{}
class ShowDatePickerErrorState extends ToDoStates{}

class ShowTimePickerSuccessState extends ToDoStates{}
class ShowTimePickerErrorState extends ToDoStates{}

class PickedImageSuccessState extends ToDoStates{}
class PickedImageErrorState extends ToDoStates{}

class UploadImageLoadingState extends ToDoStates{}
class UploadImageSuccessState extends ToDoStates{}
class UploadImageErrorState extends ToDoStates{}

class UserUpdateLoadingState extends ToDoStates{}
class UserUpdateSuccessState extends ToDoStates{}
class UserUpdateErrorState extends ToDoStates{}

class DeleteTaskErrorState extends ToDoStates{}

class UpdateTaskErrorState extends ToDoStates{}

class RemoveTokenSuccessState extends ToDoStates{}

