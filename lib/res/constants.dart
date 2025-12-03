class Constants {
  static String getSuggestions(String diagnosedLabel) {
    switch (diagnosedLabel) {
      case 'Basal Cell Carcinoma (Cancer)':
        return '1. Seek immediate medical attention for proper diagnosis and treatment. \n2. Basal cell carcinoma often appears as a waxy bump that grows slowly. \n3. Avoid prolonged sun exposure and use sunscreen regularly.';
      case 'Nevus (Non-Cancerous)':
        return '1. Regularly monitor the nevus for any changes and consult a dermatologist if there are concerns. \n2. Remember to protect your skin from excessive sun exposure. \n3. Consider wearing protective clothing and seeking shade during peak sun hours.';
      case 'Melanoma (Cancer)':
        return '1. Urgently consult with a dermatologist or oncologist for further evaluation and treatment options. \n2. Melanoma may develop from an existing mole or appear as a new mole with irregular borders. \n3. Perform regular self-examinations of your skin and report any suspicious changes to your healthcare provider.';
      default:
        return '';
    }
  }
}
