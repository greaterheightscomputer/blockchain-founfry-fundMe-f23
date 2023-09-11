-include .env

build:; forge build
# run the above command like this  
# adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ make build

deploy-sepolia:
	forge script script/DeployFundMe.s.sol:DeployFundMe --rpc-url $(SEPOLIA_RPC_URL) --private-key $(SEPOLIA_PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY)
	-vvvv
# run the above command like this  
# adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ make deploy-sepolia
# if Makefile is not setup on your system, you can deploy to Sepolia chain like this 
# adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ source .env
# forge script script/DeployFundMe.s.sol:DeployFundMe --rpc-url $SEPOLIA_RPC_URL --private-key $SEPOLIA_PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_API_KEY -vvvv
# copy the Contract Address: 0x66E1B98A44594c3aB0519C7c002EBe1dbC5e6101 and past it on etherscan to view the verified contract and details about the contract deployed

# Push to GitHub
# before push to github remember to add .env, broadcast and lib folder onto .gitignore file 
# adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ git --version
# git version 2.34.1
# adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ git status
# adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ git add .
# adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ git commit -m "our first commit!" 
# create a new repository: 
# adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ git remote add origin https://github.com/greaterheightscomputer/blockchain-founfry-fundMe-f23.git
# adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ git branch -M main
# adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ git push -u origin main
# github url: https://github.com/greaterheightscomputer/blockchain-founfry-fundMe-f23.git