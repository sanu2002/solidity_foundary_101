Summary
Use Library for Stateless Utility Functions: If you don't need state and want to reuse functions, use a library.
Use Contract for Stateful Interactions: If you need state or the contract needs to be deployed, use a contract and initialize it with its address.
Since you originally intended to use Mathtest like a library, converting it to a library (first example) would be the correct approach.


Summary
Use Libraries for reusable, stateless functions that can be shared across multiple contracts.
Use Contracts for stateful interactions, complex workflows, and when persistent storage or unique addresses are required.





Quick-Node:-  https://www.quicknode.com/guides/ethereum-development/smart-contracts/a-broad-overview-of-reentrancy-attacks-in-solidity-contracts#:~:text=A%20reentrancy%20attack%20is%20a%20type%20of,it%20until%20the%20victim%20contract%20goes%20bankrupt.



//   Security Analysis With Slither
// I generally use Foundry alongside other security tools when doing reviews of existing code bases. Slither is by no means a simple fix when it comes to smart contract security but it is useful and provides automated checks for things like reentrancy bugs. To use slither I run it from WSL (Windows subsystem for linux) and it can be installed with the following commands (note 0.8.13 is the current version of solc used in the foundry demo contract. Change this to whatever version you have set in the Solidity file):
