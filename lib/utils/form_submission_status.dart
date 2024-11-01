abstract class FormSubmissionStatus{
  const FormSubmissionStatus();
}

class FormInitialStatus extends FormSubmissionStatus {
  const FormInitialStatus();
}

class FormSubmittingStatus extends FormSubmissionStatus {
}

class FormSuccessStatus extends FormSubmissionStatus {
}

class FormFailStatus extends FormSubmissionStatus {
  final Object exception;

  const FormFailStatus(this.exception);
}