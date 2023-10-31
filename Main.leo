// Imports
@import(aleo_std);
@import(leo-chat);

// Circuit
circuit Chat {
    // Inputs
    message: Message;
    secret_key: SecretKey;

    // Outputs
    decrypted_message: DecryptedMessage;
    success: Success;
    
    // Constraints and computations
    function main(message: Message, secret_key: SecretKey) -> (DecryptedMessage, Success) {
        // Decrypt the message using the secret key
        let decrypted_message = leo_chat::decrypt(message, secret_key);

        // Check if the decryption was successful by comparing the checksums
        let success = leo_chat::verify_checksum(message.checksum, decrypted_message.checksum);

        // Return the outputs
        return (decrypted_message, success);
    }
}

// Main function
function main() {
    // Generate a random secret key for Alice and Bob
    let secret_key = leo_chat::generate_secret_key();

    // Generate a QR code for the secret key and print it to the terminal
    let qr_code = leo_chat::generate_qr_code(secret_key);
    console.log("QR code for the secret key:");
    console.log(qr_code);

    // Generate an encrypted message from Alice to Bob
    let alice_message = leo_chat::encrypt("Hello Bob!", secret_key);

    // Print Alice's message to Bob
    console.log("Alice's message to Bob:");
    console.log("Encrypted message: {}", alice_message.message);
    console.log("Checksum: {}", alice_message.checksum);

    // Generate an encrypted message from Bob to Alice
    let bob_message = leo_chat::encrypt("Hello Alice!", secret_key);

    // Print Bob's message to Alice
    console.log("Bob's message to Alice:");
    console.log("Encrypted message: {}", bob_message.message);
    console.log("Checksum: {}", bob_message.checksum);

    // Create an instance of the Chat circuit with Alice's message and secret key as inputs
    let alice_chat = Chat {
        message: alice_message,
        secret_key: secret_key,
    };

    // Run the Chat circuit and get the outputs
    let (alice_decrypted_message, alice_success) = alice_chat.main(alice_message, secret_key);

    // Print Alice's decrypted message and success status
    console.log("Alice's decrypted message:");
    console.log("Decrypted message: {}", alice_decrypted_message.message);
    console.log("Success: {}", alice_success.success);

    // Create an instance of the Chat circuit with Bob's message and secret key as inputs
    let bob_chat = Chat {
        message: bob_message,
        secret_key: secret_key,
    };

    // Run the Chat circuit and get the outputs
    let (bob_decrypted_message, bob_success) = bob_chat.main(bob_message, secret_key);

    // Print Bob's decrypted message and success status
    console.log("Bob's decrypted message:");
    console.log("Decrypted message: {}", bob_decrypted_message.message);
    console.log("Success: {}", bob_success.success);
}
