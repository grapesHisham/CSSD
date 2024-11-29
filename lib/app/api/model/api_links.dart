class ApiLinks{

  static const String baseIp = "http://192.168.0.251:65113/api/" ;
  static const String baseurl  = 'Department/';
  //cssd user
  static const String preLoginAuth = "Home/PreLoginAuthentication";
  static const String login = "Home/Login";

  //department user
  static const String departementList = 'DepartmentList';  //departments in the hospital
  static const String getItemName = 'GetItemName'; //items under a particular department
  static const String getRequestedCount = 'GetRequestedCount'; 
  static const String getRequestDetails = 'GetRequested_Details';
  static const String getPendingRequestCount = 'GetPendingRequestCount';
  static const String getPendingRequestdetails = 'GetPendingRequestdetails';
  static const String getDepartmentwiseStockDetails = 'GetDepartmentwiseStock_Details'; // stock for each department
  static const String qtyValidation = 'QtyValidation'; // amount of valid quantity while doing used item entry
  static const String usedItemEntry = 'UsedItemEntry';  // to post used items
  static const String getUsedItemNames = 'GetUsedItemNames';  // for search suggessions of used items list 
  static const String sendToCssd = 'SendToCssd';  // to send items to cssd for sterilization
  static const String departmentwiseUsedItemList = 'Departmentwise_UsedItemList';  // to get saved used items list for a particular department
  static const String getCssdSentItems = 'GetCssdSentItems';  // to display my requests on department dashboard
  static const String getCssdSentItemDetails = 'GetCssdSentItem_Details';  // to display my requests details containing items within a request on department dashboard
  static const String getPackagedetails = 'GetPackagedetails';  // to get items within a package to add to used items list 
  
}


