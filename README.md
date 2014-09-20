ECE382_Lab2
===========

Subroutines - "Cryptography"



__*PRELAB DISCUSSION*__

For the prelab, I first looked at what was to be accomplished. I am given an encrypted message and a key (for b and below functionality), and the message is to be decrypted using an xor, using subroutines. The problem is that the key will not always be a byte long (or not even present in the A functionality). My process will include finding the message length, the key length, and then decrypting the message with the two subroutines. The first subroutine will call the key to shift through the message until it hits the end of the message. The second subroutine will be called within the first to decrypt each chunk using the key. Here is a flowchart by which I will follow:


