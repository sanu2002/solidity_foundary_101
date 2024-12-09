-include .env 

# build: 
# 	forge build 

build:;forge build 

deploy-sepolia:;forge script script/Funddeploy.s.sol  --rpc-url $(SEPOLIA_RPC_URL) --private-key $(Private_Key)  --broadcast --verify --etherscan-api-key $(Ether_Scan_Api_Key) -vvvv

test:; forge test 

snapshot:;forge snapshot

anvil:;anvil 

update:;forge update

rm:
	rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

