class Request {
  final String requestID;
  final String requestDate;
  final String requestTime;
  final String requestDepartment;
  final String requestSubTitle;
  final String requestTitle;

  Request({
    required this.requestTime,
    required this.requestID,
    required this.requestDate,
    required this.requestDepartment,
    required this.requestSubTitle,
    required this.requestTitle,
  });
}

List<Request> sampleRequestsList = [
  Request(
    requestID: '23',
    requestDate: '12/10/2024',
    requestDepartment: 'Operation Theater',
    requestTime: '12:30 am',
    requestSubTitle:
        "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
    requestTitle: 'OT PACKAGE',
  ),
  Request(
    requestTime: '12:30 am',
    requestID: '56',
    requestDate: '11/10/2024',
    requestDepartment: 'Cardiology',
    requestSubTitle:
        "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
    requestTitle: 'Single items',
  ),
  Request(
    requestTime: '12:30 am',
    requestID: '23',
    requestDate: '12/10/2024',
    requestDepartment: 'Operation Theater',
    requestSubTitle:
        "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
    requestTitle: 'OT Package & Other items',
  ),
  Request(
    requestTime: '12:30 am',
    requestID: '23',
    requestDate: '12/10/2024',
    requestDepartment: 'Operation Theater',
    requestSubTitle:
        "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
    requestTitle: 'Single items',
  ),
];

List<Request> sampleLowPriorityRequestsList = [
  Request(
    requestID: '23',
    requestDate: '12/10/2024',
    requestDepartment: 'Operation Theater',
    requestTime: '12:30 am',
    requestSubTitle:
        "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
    requestTitle: 'OT PACKAGE',
  ),
  Request(
    requestTime: '2:30 pm',
    requestID: '3',
    requestDate: '1/10/2024',
    requestDepartment: 'Operation Theater',
    requestSubTitle: " BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
    requestTitle: 'OT Package & Other items',
  ),
];
