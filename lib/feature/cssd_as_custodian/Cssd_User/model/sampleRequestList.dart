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

// List<Request> sampleHighPriorityRequestsList = [
//   Request(
//     requestID: '23',
//     requestDate: '12/10/2024',
//     requestDepartment: 'Operation Theater',
//     requestTime: '12:30 am',
//     requestSubTitle:
//         "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
//     requestTitle: 'OT PACKAGE',
//   ),
//   Request(
//     requestTime: '12:30 am',
//     requestID: '56',
//     requestDate: '11/10/2024',
//     requestDepartment: 'Cardiology',
//     requestSubTitle:
//         "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
//     requestTitle: 'Single items',
//   ),
//   Request(
//     requestTime: '12:30 am',
//     requestID: '23',
//     requestDate: '12/10/2024',
//     requestDepartment: 'Operation Theater',
//     requestSubTitle:
//         "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
//     requestTitle: 'OT Package & Other items',
//   ),
//   Request(
//     requestTime: '12:30 am',
//     requestID: '23',
//     requestDate: '12/10/2024',
//     requestDepartment: 'Operation Theater',
//     requestSubTitle:
//         "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
//     requestTitle: 'Single items',
//   ),

//   Request(
//     requestID: '23',
//     requestDate: '12/10/2024',
//     requestDepartment: 'Operation Theater',
//     requestTime: '12:30 am',
//     requestSubTitle:
//         "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
//     requestTitle: 'OT PACKAGE',
//   ),
//   Request(
//     requestTime: '12:30 am',
//     requestID: '56',
//     requestDate: '11/10/2024',
//     requestDepartment: 'Cardiology',
//     requestSubTitle:
//         "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
//     requestTitle: 'Single items',
//   ),
//   Request(
//     requestTime: '12:30 am',
//     requestID: '23',
//     requestDate: '12/10/2024',
//     requestDepartment: 'Operation Theater',
//     requestSubTitle:
//         "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
//     requestTitle: 'OT Package & Other items',
//   ),
//   Request(
//     requestTime: '12:30 am',
//     requestID: '23',
//     requestDate: '12/10/2024',
//     requestDepartment: 'Operation Theater',
//     requestSubTitle:
//         "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
//     requestTitle: 'Single items',
//   ),
//   Request(
//     requestID: '23',
//     requestDate: '12/10/2024',
//     requestDepartment: 'Operation Theater',
//     requestTime: '12:30 am',
//     requestSubTitle:
//         "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
//     requestTitle: 'OT PACKAGE',
//   ),
//   Request(
//     requestTime: '12:30 am',
//     requestID: '56',
//     requestDate: '11/10/2024',
//     requestDepartment: 'Cardiology',
//     requestSubTitle:
//         "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
//     requestTitle: 'Single items',
//   ),
//   Request(
//     requestTime: '12:30 am',
//     requestID: '23',
//     requestDate: '12/10/2024',
//     requestDepartment: 'Operation Theater',
//     requestSubTitle:
//         "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
//     requestTitle: 'OT Package & Other items',
//   ),
//   Request(
//     requestTime: '12:30 am',
//     requestID: '23',
//     requestDate: '12/10/2024',
//     requestDepartment: 'Operation Theater',
//     requestSubTitle:
//         "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
//     requestTitle: 'Single items',
//   ),
//   Request(
//     requestID: '23',
//     requestDate: '12/10/2024',
//     requestDepartment: 'Operation Theater',
//     requestTime: '12:30 am',
//     requestSubTitle:
//         "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
//     requestTitle: 'OT PACKAGE',
//   ),
//   Request(
//     requestTime: '12:30 am',
//     requestID: '56',
//     requestDate: '11/10/2024',
//     requestDepartment: 'Cardiology',
//     requestSubTitle:
//         "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
//     requestTitle: 'Single items',
//   ),
//   Request(
//     requestTime: '12:30 am',
//     requestID: '23',
//     requestDate: '12/10/2024',
//     requestDepartment: 'Operation Theater',
//     requestSubTitle:
//         "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
//     requestTitle: 'OT Package & Other items',
//   ),
//   Request(
//     requestTime: '12:30 am',
//     requestID: '23',
//     requestDate: '12/10/2024',
//     requestDepartment: 'Operation Theater',
//     requestSubTitle:
//         "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
//     requestTitle: 'Single items',
//   ),
// ];
// List<Request> sampleMediumPriorityRequestsList = [
//   Request(
//     requestID: '23',
//     requestDate: '12/10/2024',
//     requestDepartment: 'Operation Theater',
//     requestTime: '12:30 am',
//     requestSubTitle:
//         "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
//     requestTitle: 'OT PACKAGE',
//   ),
//   Request(
//     requestTime: '12:30 am',
//     requestID: '56',
//     requestDate: '11/10/2024',
//     requestDepartment: 'Cardiology',
//     requestSubTitle:
//         "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
//     requestTitle: 'Single items',
//   ),
//   Request(
//     requestTime: '12:30 am',
//     requestID: '23',
//     requestDate: '12/10/2024',
//     requestDepartment: 'Operation Theater',
//     requestSubTitle:
//         "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
//     requestTitle: 'OT Package & Other items',
//   ),
//   Request(
//     requestTime: '12:30 am',
//     requestID: '23',
//     requestDate: '12/10/2024',
//     requestDepartment: 'Operation Theater',
//     requestSubTitle:
//         "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
//     requestTitle: 'Single items',
//   ),
// ];

// List<Request> sampleLowPriorityRequestsList = [
//   Request(
//     requestID: '23',
//     requestDate: '12/10/2024',
//     requestDepartment: 'Operation Theater',
//     requestTime: '12:30 am',
//     requestSubTitle:
//         "NEEDLE NO 24 X 1 , BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
//     requestTitle: 'OT PACKAGE',
//   ),
//   Request(
//     requestTime: '2:30 pm',
//     requestID: '3',
//     requestDate: '1/10/2024',
//     requestDepartment: 'Operation Theater',
//     requestSubTitle: " BIOCOMPOSITE INTERFERENCE SCREW 7 X 28 MM",
//     requestTitle: 'OT Package & Other items',
//   ),
// ];

// High Priority Requests
List<Request> sampleHighPriorityRequestsList = [
  Request(
    requestID: '1001',
    requestDate: '21/10/2024',
    requestTime: '10:15 am',
    requestDepartment: 'Operation Theater',
    requestSubTitle: "SCALPEL BLADE NO 11, SURGICAL SUTURE VICRYL 3-0",
    requestTitle: 'Emergency Surgery - OT Package',
  ),
  Request(
    requestID: '1002',
    requestDate: '21/10/2024',
    requestTime: '11:00 am',
    requestDepartment: 'Cardiology',
    requestSubTitle: "CARDIAC CATHETER, GUIDE WIRE 0.014 inch",
    requestTitle: 'Angioplasty Instruments',
  ),
  Request(
    requestID: '1003',
    requestDate: '20/10/2024',
    requestTime: '09:30 am',
    requestDepartment: 'ICU',
    requestSubTitle: "ENDOTRACHEAL TUBE 7.5 MM, VENTILATOR CIRCUIT",
    requestTitle: 'ICU Emergency Setup',
  ),
  Request(
    requestID: '1004',
    requestDate: '20/10/2024',
    requestTime: '08:00 am',
    requestDepartment: 'Operation Theater',
    requestSubTitle: "SCREW 6 X 20 MM, DRILL BIT 3.5 MM, CANNULATED SCREW",
    requestTitle: 'Orthopedic Surgery Kit',
  ),
  Request(
    requestID: '1005',
    requestDate: '19/10/2024',
    requestTime: '02:30 pm',
    requestDepartment: 'Neurosurgery',
    requestSubTitle: "CRANIOTOMY KIT, DURAPATCH, COTTONOID PATTIES",
    requestTitle: 'Neurosurgery OT Instruments',
  ),
];

// Medium Priority Requests
List<Request> sampleMediumPriorityRequestsList = [
  Request(
    requestID: '2001',
    requestDate: '19/10/2024',
    requestTime: '11:00 am',
    requestDepartment: 'Laboratory',
    requestSubTitle: "BIOPSY NEEDLE, SPECIMEN CONTAINER",
    requestTitle: 'Pathology Lab Tools',
  ),
  Request(
    requestID: '2002',
    requestDate: '18/10/2024',
    requestTime: '03:45 pm',
    requestDepartment: 'Endoscopy',
    requestSubTitle: "ENDOSCOPE BRUSHES, STERILE SYRINGES 5 ML",
    requestTitle: 'Endoscopy Reprocessing',
  ),
  Request(
    requestID: '2003',
    requestDate: '18/10/2024',
    requestTime: '12:30 pm',
    requestDepartment: 'Dermatology',
    requestSubTitle: "DERMATOME BLADE, STAPLER REMOVER",
    requestTitle: 'Dermatology Minor Procedure Kit',
  ),
];

// Low Priority Requests
List<Request> sampleLowPriorityRequestsList = [
  Request(
    requestID: '3001',
    requestDate: '17/10/2024',
    requestTime: '02:00 pm',
    requestDepartment: 'General Surgery',
    requestSubTitle: "SURGICAL CLAMP, HEMOSTAT",
    requestTitle: 'Routine Surgery Instruments',
  ),
  Request(
    requestID: '3002',
    requestDate: '16/10/2024',
    requestTime: '10:45 am',
    requestDepartment: 'Dental',
    requestSubTitle: "DENTAL MIRROR, STERILE FORCEPS",
    requestTitle: 'Dental Instruments Reprocessing',
  ),
  Request(
    requestID: '3003',
    requestDate: '16/10/2024',
    requestTime: '03:00 pm',
    requestDepartment: 'Urology',
    requestSubTitle: "CYSTOSCOPE SHEATH, GRASPING FORCEPS",
    requestTitle: 'Urology Procedure Instruments',
  ),
];
