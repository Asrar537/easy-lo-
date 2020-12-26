abstract class StringValidator {
  bool isValid(String value);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }
}

class EmailAndPassowrdValidator {
  final StringValidator nameValidator = NonEmptyStringValidator();
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();

  final String invalidNameText = 'Name cannot be empty';
  final String invalidEmailText = 'Email cannot be empty';
  final String invalidPasswordText = 'Password cannot be empty';
}

class GeneralValidator{
  final StringValidator fieldValidator = NonEmptyStringValidator();

  final String invalidFieldText = 'Field cannot be empty';
}