ECE382_Lab2
===========

Subroutines - "Cryptography"



__*PRELAB DISCUSSION*__

For the prelab, I first looked at what was to be accomplished. I am given an encrypted message and a key (for b and below functionality), and the message is to be decrypted using an xor, using subroutines. The problem is that the key will not always be a byte long (or not even present in the A functionality). My process will include finding the message length, the key length, and then decrypting the message with the two subroutines. The first subroutine will call the key to shift through the message until it hits the end of the message. The second subroutine will be called within the first to decrypt each chunk using the key. Here is a flowchart by which I will follow:


![](https://github.com/dustyweisner/ECE382_Lab2/blob/master/Images/Flowchart.GIF?raw=true)


Using this flowchart, I will be able to obtain B and required functionality.


__*LAB DISCUSSION AND RESULTS*__


My lab, when demoed for Capt. Trimble, received required and B functionality, as previously stated in the prelab. This was accomplished by following the simple flowchart from the prelab.

__Required Functionality__

For required functionality, the decrypted message was found given the following encrypted message:

`0xef,0xc3,0xc2,0xcb,0xde,0xcd,0xd8,0xd9,0xc0,0xcd,0xd8,0xc5,0xc3,0xc2,0xdf,0x8d,0x8c,0x8c,0xf5,0xc3,0xd9,0x8c,0xc8,0xc9,0xcf,0xde,0xd5,0xdc,0xd8,0xc9,0xc8,0x8c,0xd8,0xc4,0xc9,0x8c,0xe9,0xef,0xe9,0x9f,0x94,0x9e,0x8c,0xc4,0xc5,0xc8,0xc8,0xc9,0xc2,0x8c,0xc1,0xc9,0xdf,0xdf,0xcd,0xcb,0xc9,0x8c,0xcd,0xc2,0xc8,0x8c,0xcd,0xcf,0xc4,0xc5,0xc9,0xda,0xc9,0xc8,0x8c,0xde,0xc9,0xdd,0xd9,0xc5,0xde,0xc9,0xc8,0x8c,0xca,0xd9,0xc2,0xcf,0xd8,0xc5,0xc3,0xc2,0xcd,0xc0,0xc5,0xd8,0xd5,0x8f`

The key was `0xac`

Because there is not a specific length to the encrypted messages, the first step is to add bytes at the end of the message and key so that I know where the ends of the message and key are. This happens to be `0x11, 0x22, 0x33` and with it I make sure that the size of the message and key are counted correctly. Then, the `call #decryptMessage` method calls the whole decryption, which ultimately XOR's the key with the message. Here are the results from the XOR:


![](https://github.com/dustyweisner/ECE382_Lab2/blob/master/Images/RequiredFunctionalityResults.GIF?raw=true)


Because the results are words that are recognizable and the decrypted message made sense to the lab, in this case I can conclude that the results were correct, and because there are no symbols or characters after the hash at the end of the sentence, I know that the message stopped XORing at the end of the message and not a little after.


__B Functionality__

For the B Functionality, the decrypted message was found given the following encrypted message:

`0xf8,0xb7,0x46,0x8c,0xb2,0x46,0xdf,0xac,0x42,0xcb,0xba,0x03,0xc7,0xba,0x5a,0x8c,0xb3,0x46,0xc2,0xb8,0x57,0xc4,0xff,0x4a,0xdf,0xff,0x12,0x9a,0xff,0x41,0xc5,0xab,0x50,0x82,0xff,0x03,0xe5,0xab,0x03,0xc3,0xb1,0x4f,0xd5,0xff,0x40,0xc3,0xb1,0x57,0xcd,0xb6,0x4d,0xdf,0xff,0x4f,0xc9,0xab,0x57,0xc9,0xad,0x50,0x80,0xff,0x53,0xc9,0xad,0x4a,0xc3,0xbb,0x50,0x80,0xff,0x42,0xc2,0xbb,0x03,0xdf,0xaf,0x42,0xcf,0xba,0x50,0x8f`

The key was `0xacdf23`

Because there is not a specific length to the encrypted messages, again the first step is to add bytes at the end of the message and key so that I know where the ends of the message and key are. Once again this is `0x11, 0x22, 0x33` and with it I made sure that the size of the message and key are counted correctly. Again, the `call #decryptMessage` method calls the whole decryption, which ultimately XOR's the key with the message. Here are the results from the XOR for B functionality:


![](https://github.com/dustyweisner/ECE382_Lab2/blob/master/Images/BFunctionalityResults.GIF?raw=true)


Because the results are words that are recognizable and the decrypted message was a hint to the A functionality like the lab handout said, in this case I can conclude that the results were correct, and because there are no symbols or characters after the hash at the end of the sentence, I know that the message stopped XORing at the end of the message and not a little after.


The A functionality was not achieved.
