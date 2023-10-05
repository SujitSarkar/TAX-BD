bool validateEmail(String emailAddress) => RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    .hasMatch(emailAddress);

bool validatePassword(String password) => password.length >= 8;

bool isBullish(String sentiment) =>
    sentiment.toLowerCase().trim() == 'bullish' ||
    sentiment.toLowerCase().trim() == 'slightly bullish';
