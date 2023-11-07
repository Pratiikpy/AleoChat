# AleoChat


This is a private chat system that allows users to send and receive encrypted messages using zero-knowledge cryptography. It is built using the [Leo programming language] and the [Aleo platform], which enable developers to write, run, and host fully private applications on a decentralized network.
# Discord : 0xprtk.eth
## Features

- Users can generate and share a QR code that contains their secret key, so that they can easily scan it with their devices and join the chat session.
- Users can encrypt and decrypt their messages using the same secret key by XORing each character with the corresponding character in the key.
- Users can verify if the decryption was successful by comparing the checksums of the encrypted and decrypted messages.
- Users can set a timer for their messages, so that they can automatically delete them after a certain period of time. (TODO)
- Users can send images, videos, or other files along with their messages, and encrypt them using the same secret key. (TODO)

## Dependencies

To run this project, you will need to install the following dependencies on your computer:

- [Leo programming language]: This is the language that is used to write the core logic and the main function of the project. You can find the installation instructions and download links on the official website.
- [Aleo Studio IDE]: This is the integrated development environment that is used to compile, test, and run the project. You can find the installation instructions and download links on the official website.
- [QR code API]: This is an external API that is used to generate QR codes for the secret keys. You will need an internet connection to access this API.

## Usage

To use this project, you will need to follow these steps:

- Clone this repository from GitHub to your local machine
- Open the private-chat-system folder in Aleo Studio and run the `leo build` command to compile the project. This will generate a proof and a public input file in the `outputs` folder.
- Run the `leo setup` command to generate a proving and a verification key for the project. These keys are used to verify the correctness of the program execution on the Aleo network.
- Run the `leo test` command to run the unit tests for the project. This will check if the program logic is working as expected and if there are any errors or bugs in the code.
- Run the `leo run` command to run the main function of the project. This will simulate a chat session between two users, Alice and Bob, who exchange encrypted messages using a shared secret key. You can see the output of the program in the terminal or in the `outputs/main.out` file.

## License

This project is licensed under the MIT License 
