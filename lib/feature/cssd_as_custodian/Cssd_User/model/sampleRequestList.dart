class SampleRequest {
  final String requestID;
  final String requestDate;
  final String requestTime;
  final String requestDepartment;
  final String requestSubTitle;
  final String requestTitle;

  SampleRequest({
    required this.requestTime,
    required this.requestID,
    required this.requestDate,
    required this.requestDepartment,
    required this.requestSubTitle,
    required this.requestTitle,
  });
}

// High Priority Requests
List<SampleRequest> sampleHighPriorityRequestsList = [
  SampleRequest(
    requestID: '1001',
    requestDate: '21/10/2024',
    requestTime: '10:15 am',
    requestDepartment: 'Operation Theater',
    requestSubTitle: "SCALPEL BLADE NO 11, SURGICAL SUTURE VICRYL 3-0",
    requestTitle: 'Emergency Surgery - OT Package',
  ),
  SampleRequest(
    requestID: '1002',
    requestDate: '21/10/2024',
    requestTime: '11:00 am',
    requestDepartment: 'Cardiology',
    requestSubTitle: "CARDIAC CATHETER, GUIDE WIRE 0.014 inch",
    requestTitle: 'Angioplasty Instruments',
  ),
  SampleRequest(
    requestID: '1003',
    requestDate: '20/10/2024',
    requestTime: '09:30 am',
    requestDepartment: 'ICU',
    requestSubTitle: "ENDOTRACHEAL TUBE 7.5 MM, VENTILATOR CIRCUIT",
    requestTitle: 'ICU Emergency Setup',
  ),
  SampleRequest(
    requestID: '1004',
    requestDate: '20/10/2024',
    requestTime: '08:00 am',
    requestDepartment: 'Operation Theater',
    requestSubTitle: "SCREW 6 X 20 MM, DRILL BIT 3.5 MM, CANNULATED SCREW",
    requestTitle: 'Orthopedic Surgery Kit',
  ),
  SampleRequest(
    requestID: '1005',
    requestDate: '19/10/2024',
    requestTime: '02:30 pm',
    requestDepartment: 'Neurosurgery',
    requestSubTitle: "CRANIOTOMY KIT, DURAPATCH, COTTONOID PATTIES",
    requestTitle: 'Neurosurgery OT Instruments',
  ),
];

// Medium Priority Requests
List<SampleRequest> sampleMediumPriorityRequestsList = [
  SampleRequest(
    requestID: '2001',
    requestDate: '19/10/2024',
    requestTime: '11:00 am',
    requestDepartment: 'Laboratory',
    requestSubTitle: "BIOPSY NEEDLE, SPECIMEN CONTAINER",
    requestTitle: 'Pathology Lab Tools',
  ),
  SampleRequest(
    requestID: '2002',
    requestDate: '18/10/2024',
    requestTime: '03:45 pm',
    requestDepartment: 'Endoscopy',
    requestSubTitle: "ENDOSCOPE BRUSHES, STERILE SYRINGES 5 ML",
    requestTitle: 'Endoscopy Reprocessing',
  ),
  SampleRequest(
    requestID: '2003',
    requestDate: '18/10/2024',
    requestTime: '12:30 pm',
    requestDepartment: 'Dermatology',
    requestSubTitle: "DERMATOME BLADE, STAPLER REMOVER",
    requestTitle: 'Dermatology Minor Procedure Kit',
  ),
];

// Low Priority Requests
List<SampleRequest> sampleLowPriorityRequestsList = [
  SampleRequest(
    requestID: '3001',
    requestDate: '17/10/2024',
    requestTime: '02:00 pm',
    requestDepartment: 'General Surgery',
    requestSubTitle: "SURGICAL CLAMP, HEMOSTAT",
    requestTitle: 'Routine Surgery Instruments',
  ),
  SampleRequest(
    requestID: '3002',
    requestDate: '16/10/2024',
    requestTime: '10:45 am',
    requestDepartment: 'Dental',
    requestSubTitle: "DENTAL MIRROR, STERILE FORCEPS",
    requestTitle: 'Dental Instruments Reprocessing',
  ),
  SampleRequest(
    requestID: '3003',
    requestDate: '16/10/2024',
    requestTime: '03:00 pm',
    requestDepartment: 'Urology',
    requestSubTitle: "CYSTOSCOPE SHEATH, GRASPING FORCEPS",
    requestTitle: 'Urology Procedure Instruments',
  ),
];
