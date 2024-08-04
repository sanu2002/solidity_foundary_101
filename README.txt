Summary
Use Library for Stateless Utility Functions: If you don't need state and want to reuse functions, use a library.
Use Contract for Stateful Interactions: If you need state or the contract needs to be deployed, use a contract and initialize it with its address.
Since you originally intended to use Mathtest like a library, converting it to a library (first example) would be the correct approach.


Summary
Use Libraries for reusable, stateless functions that can be shared across multiple contracts.
Use Contracts for stateful interactions, complex workflows, and when persistent storage or unique addresses are required.





Quick-Node:-  https://www.quicknode.com/guides/ethereum-development/smart-contracts/a-broad-overview-of-reentrancy-attacks-in-solidity-contracts#:~:text=A%20reentrancy%20attack%20is%20a%20type%20of,it%20until%20the%20victim%20contract%20goes%20bankrupt.



