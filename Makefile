-include .env

all: clean remove install update build

install:
	@forge install smartcontractkit/chainlink-brownie-contracts@1.1.1 --no-commit && forge install foundry-rs/forge-std@v1.9.1 --no-commit
clean:
	@forge clean
remove:
	@rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules
update:
	@forge update
build:
	@forge build
test:
	@forge test
snapshot:
	@forge snapshot
anvil:
	anvil --steps-tracing
deploy:
	@forge script script/DeployFundMe.s.sol:DeployFundMe --private-key ${DEFAULT_ANVIL_KEY} --broadcast

.PHONY: install clean remove update build test snapshot deploy anvil