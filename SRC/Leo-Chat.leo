// Imports
@import(aleo_std);

// Types

// A type that represents an encrypted message with a checksum
type Message {
  message: String;
  checksum: u32;
}

// A type that represents a shared secret key between two users
type SecretKey {
  key: String;
}

// A type that represents a decrypted message with a checksum
type DecryptedMessage {
  message: String;
  checksum: u32;
}

// A type that represents a boolean value indicating whether the decryption was successful or not
type Success {
  success: bool;
}

// Functions

// A function that generates a random secret key of 16 characters using ASCII characters from 32 to 126
function generate_secret_key() -> SecretKey {
  // Initialize an empty string for the key
  let mut key = "";

  // Loop 16 times to generate 16 random characters
  for i in 0..16 {
      // Generate a random number from 32 to 126 using aleo_std::rand::random()
      let num = aleo_std::rand::random() % 95 + 32;

      // Convert the number to a character using aleo_std::char::from_u8()
      let char = aleo_std::char::from_u8(num);

      // Append the character to the key string using aleo_std::string::push()
      key.push(char);
  }

  // Return the key as a SecretKey type
  return SecretKey { key: key };
}

// A function that encrypts a message using a secret key by XORing each character with the corresponding character in the key
function encrypt(message: String, secret_key: SecretKey) -> Message {
  // Initialize an empty string for the encrypted message
  let mut encrypted_message = "";

  // Initialize a variable for the checksum
  let mut checksum = 0u32;

  // Loop through each character in the message using aleo_std::string::chars()
  for (i, char) in message.chars().enumerate() {
      // Get the corresponding character in the key using aleo_std::string::get()
      let key_char = secret_key.key.get(i % 16);

      // XOR the two characters using aleo_std::char::xor()
      let encrypted_char = char.xor(key_char);

      // Append the encrypted character to the encrypted message string using aleo_std::string::push()
      encrypted_message.push(encrypted_char);

      // Add the ASCII value of the encrypted character to the checksum using aleo_std::char::to_u32()
      checksum += encrypted_char.to_u32();
  }

  // Return the encrypted message and the checksum as a Message type
  return Message { message: encrypted_message, checksum: checksum };
}

// A function that decrypts a message using a secret key by XORing each character with the corresponding character in the key
function decrypt(message: Message, secret_key: SecretKey) -> DecryptedMessage {
  // Initialize an empty string for the decrypted message
  let mut decrypted_message = "";

  // Initialize a variable for the checksum
  let mut checksum = 0u32;

  // Loop through each character in the message using aleo_std::string::chars()
  for (i, char) in message.message.chars().enumerate() {
      // Get the corresponding character in the key using aleo_std::string::get()
      let key_char = secret_key.key.get(i % 16);

      // XOR the two characters using aleo_std::char::xor()
      let decrypted_char = char.xor(key_char);

      // Append the decrypted character to the decrypted message string using aleo_std::string::push()
      decrypted_message.push(decrypted_char);

      // Add the ASCII value of the decrypted character to the checksum using aleo_std::char::to_u32()
      checksum += decrypted_char.to_u32();
  }

  // Return the decrypted message and the checksum as a DecryptedMessage type
  return DecryptedMessage { message: decrypted_message, checksum: checksum };
}

// A function that verifies if the decryption was successful by comparing the checksums of the encrypted and decrypted messages
function verify_checksum(encrypted_checksum: u32, decrypted_checksum: u32) -> Success {
  // Compare the two checksums using aleo_std::u32::eq()
  let success = encrypted_checksum.eq(decrypted_checksum);

  // Return the result as a Success type
  return Success { success: success };
}

// A function that generates a QR code for a secret key using an external API and returns it as a string
function generate_qr_code(secret_key: SecretKey) -> String {
  // Define the API URL with the secret key as a parameter
  let url = "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=" + secret_key.key;

  // Make a GET request to the API using aleo_std::http::get() and get the response body as a string
  let response = aleo_std::http::get(url).unwrap();
  let body = response.body();

  // Return the body as a QR code string
  return body;
}
