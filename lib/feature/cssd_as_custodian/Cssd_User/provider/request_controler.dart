import 'package:flutter/material.dart';

class RequestControler extends ChangeNotifier {
  RequestControler() {
    //init state

    //initially _filtered users will be whole list  of users
    _filteredRequestedUsers = _sampleRequestedUsers;
  }

  final ScrollController scrollController = ScrollController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController departmentTextController =
      TextEditingController();
  final TextEditingController requestedUserTextController =
      TextEditingController();

  //list of search filtered users
  List<String> _filteredRequestedUsers = [];
  String? _selectedUser;
  bool _showDropDown = false;

  //original list of users
  final List<String> _sampleRequestedUsers = [
    "Muhammed Hisham",
    "Vishnu P.S",
    "John Smith",
    "Emily Johnson",
    "Michael Brown",
    "Jessica Williams",
    "David Jones",
    "Sarah Davis",
    "James Miller",
    "Ashley Wilson",
    "Robert Moore",
    "Sophia Taylor",
  ];

  //Getters
  List<String> get filteredRequestedUsers => _filteredRequestedUsers;
  List<String> get allRequestedUsers => _sampleRequestedUsers;
  String? get selectedUser => _selectedUser;
  bool get showDropDown => _showDropDown;

  //function to update the filterlist
  void filterUsers(String searchQuery) {
    if (searchQuery.isEmpty) {
      _filteredRequestedUsers = _sampleRequestedUsers;
    } else {
      _filteredRequestedUsers = _sampleRequestedUsers
          .where(
              (user) => user.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  //funtion to update the selected user
  void updateSelectedUser(String? user) {
    _selectedUser = user;
    notifyListeners();
  }

  //function to update the show dropdown bool
  void updateShowDropdown(bool value) {
    _showDropDown = value;
    notifyListeners();
  }
}
