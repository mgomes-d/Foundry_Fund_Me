# Foundry Fund Me
This is a section of the Cyfrin Solidity course.


- [Foundry Fund Me](#foundry-fund-me)
- [Getting Started](#getting-started)
  - [Quickstart](#quickstart)
- [Usage](#usage)
  - [Deploy](#deploy)
  - [Testing](#testing)
    - [Test Coverage](#test-coverage)
  - [Local zkSync (do after)](#local-zksync-do-after)
- [Deployment to a testnet or mainnet](#deployment-to-a-testnet-or-mainnet)
  - [Scripts](#scripts)
    - [Withdraw](#withdraw)
  - [Estimate gas](#estimate-gas)
- [Formatting](#formatting)
- [Additional Info:](#additional-info)
  - [Let's talm about what "Official" means](#lets-talm-about-what-official-means)
  - [Summary](#summary)
- [Thanks!](#thanks)
# Getting Started

- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) 
  - Run `git --version` to check if it's correctly installed.
- [foundry](https://getfoundry.sh/)
  - Run `forge --version` to check if it's correctly installed.

## Quickstart

```
git clone https://github.com/mgomes-d/foundry-fund-me
cd foundry-fund-me
make
```

# Usage

## Deploy

```
forge script script/DeployFundMe.s.sol
```

## Testing

There are 4 test tiers.

1. Unit
2. Integration
3. Forked
4. Staging

```
forge test
```

or 

```
forge test --mt testFunctionName
```
or

```
forge test --fork-url $SEPOLIA_RPC_URL
```

### Test Coverage

```
forge coverage
```

## Local zkSync (do after)


# Deployment to a testnet or mainnet

1. Setup environment variables

Never store your Private-Key in a plain text and never type your Private-Key in your terminal.

We can use a `keystore` (ERC-2335: BLS12-381) that gonna encript our private-key and for use it you need to put your password.
The format is a json

- How to use it?

  - Creating a new account.
    Open a new terminal, not in vscode(for securety reason).
    ```
    cast wallet import accountName --interactive
    ```
    Past your private-key and enter a password.

    The account will be stored at `~/.foundry/keystores`.
  - How to check all your accounts?
    ```
    cast wallet list
    ```
  -  How to use the private key?
  
        You can use --account and the name of the account, after that you will need to put your password.

            forge script script/DeployFundMe.s.sol  --rpc-url 127.0.0.1:8545 --account AnvilAccount --broadcast


For more informations about the commands [wallet-commands](https://book.getfoundry.sh/reference/cast/wallet-commands).

You'll want to set your `SEPOLIA_RPC_URL` and `PRIVATE_KEY` as environment variables. You can add then to a `.env` file, similar to what you see in `.env.exemple`.

- `PRIVATE_KEY`: The private key of your account (like from [metamask](https://metamask.io/)). **NOTE:** FOR DEVELOPMENT, PLEASE USE A KEY THAT DOESN'T HAVE ANY REAL FUNDS ASSOCIATED WITH IT.
  - You can [learn how to export it here](https://support.metamask.io/managing-my-wallet/secret-recovery-phrase-and-private-keys/how-to-export-an-accounts-private-key/).
- `SEPOLIA_RPC_URL`: This is url of the sepolia testnet node wou're working with. You can get setup with one for free from [Alchemy](https://www.alchemy.com/).

Optionally, add your `ETHERSCAN_API_KEY` if you want to verify your contract on [Etherscan](https://etherscan.io/).

1. Get testnet ETH

Head over to [faucets.chain.link](https://faucets.chain.link/) and get some testnet ETH. You should see the ETH show up in your metamask.

3. Deploy on a testnet

```
forge script script/DeployFundMe.s.sol --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY --broadcast 
```

or if you want to verify with Etherscan

```
forge script script/DeployFundMe.s.sol --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_API_KEY
```

4. Deploy using anvil (local net)

Open a new terminal and type: 
```
anvil
```
Get a private key that he will generate and his RPC_URL(127.0.0.1:8545)

You can put in the .env file to update the environment variables
```
source .env
```
and to deplout is the same as Sepolia testnet
```
forge script script/DeployFundMe.s.sol --rpc-url $ANVIL_RPC_URL --private-key $ANVIL_PRIVATE_KEY --broadcast
```

if it's successful you gonna get a output like:
```
$ forge script script/DeployFundMe.s.sol  --rpc-url $ANVIL_RPC_URL --private-key $ANVIL_PRIVATE_KEY --broadcast
[⠘] Compiling...
No files changed, compilation skipped
EIP-3855 is not supported in one or more of the RPCs used.
Unsupported Chain IDs: 31337.
Contracts deployed with a Solidity version equal or higher than 0.8.20 might not work properly.
For more information, please see https://eips.ethereum.org/EIPS/eip-3855
Script ran successfully.

== Return ==
0: contract FundMe 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512

## Setting up 1 EVM.

==========================

Chain 31337

Estimated gas price: 2.000000001 gwei

Estimated total gas used for script: 2008026

Estimated amount required: 0.004016052002008026 ETH

==========================

##### anvil-hardhat
✅  [Success]Hash: 0xf26ae9993f5fdf7729ae7173de6fa0b9114543fbe28ae664f43a58d0eaa7773f
Contract Address: 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
Block: 2
Paid: 0.000747594327971145 ETH (848765 gas * 0.880802493 gwei)


##### anvil-hardhat
✅  [Success]Hash: 0x43bebf515c3ade5c6a1541c4328d0a36ddb63e33b0009fc48b735a3ba8371fed
Contract Address: 0x5FbDB2315678afecb367f032d93F642f64180aa3
Block: 1
Paid: 0.000696299000696299 ETH (696299 gas * 1.000000001 gwei)

✅ Sequence #1 on anvil-hardhat | Total Paid: 0.001443893328667444 ETH (1545064 gas * avg 0.940401247 gwei)


==========================

ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.

Transactions saved to: C:/Users/$User/foundry/foundry-fund-me\broadcast\DeployFundMe.s.sol\31337\run-latest.json

Sensitive values saved to: C:/Users/$User/foundry/foundry-fund-me/cache\DeployFundMe.s.sol\31337\run-latest.json
```

## Scripts

After deploying to a testnet or local net, you can run the scripts.

Using cast deployed locally example:

```
cast send <FUNDME_CONTRACT_ADDRESS> "fund()" --value 0.1ether --private-key <PRIVATE_KEY>
```

or
```
forge script script/Interactions.s.sol:FundFundMe --rpc-url $RPC_URL --private-key $PRIVATE_KEY --broadcast
```

### Withdraw

```
cast send <FUNDME_CONTACT_ADDRESS> "withdraw()" --private-key <PRIVATE_KEY>
```

or

```
forge script script/Interactions.s.sol:WithdrawFundMe --rpc-url $RPC_URL --private-key $PRIVATE_KEY
```

## Estimate gas

You can estimate how much gas things cost by running:

```
forge snapshot
```

And you'll see an output file called `.gas-snapshot`

# Formatting

To run code formatting:
```
forge fmt
```

# Additional Info:
Some users were having a confusion that whether Chainlink-brownie-contracts is an official Chainlink repository or not. Here is the info.
Chainlink-brownie-contracts is an official repo. The repository is owned and maintained by the chainlink team for this very purpose, and gets releases from the proper chainlink release process. You can see it's still the `smartcontractkit` org as well.

https://github.com/smartcontractkit/chainlink-brownie-contracts

## Let's talm about what "Official" means
The "official" release process is that chainlink deploys it's packages to [npm](https://www.npmjs.com/package/@chainlink/contracts). So technically, even downloading directly from `smartcontractkit/chainlink` is wrong, because it could be using unreleased code.

So, then you have two options:

1. Download from NPM and you have dependencies foreign to foundry
2. Download from the chainlink-brownie-contracts repo wich already downloads from npm and then packages it nicely for you to use in foundry.

## Configuring the priceFeed
Each chain have their own address of the price of the contract (like ETH/USD),  so we can check the chainId of the block.
We can also do our own local pricefeed using MockV3Aggregator.

## Magic Number

Magic Number is using a number without naming it. Like passing a number directly to a function.
Tranform this
```solidity
MockV3Aggregator(8, 2000e8);
```
to this
```solidity
uint8 public constant DECIMALS = 8;
int256 public constant INITIAL_PRICE = 2000e8;
MockV3Aggregator(DECIMALS, INITIAL_PRICE);
```

## Cheatcodes

```
prank(address);
```
This is a way to make the tests in foundry, where you can specify which address are sending the contract.
```
makeAddr(string memory name) internal returns(address addr);
```
This gonna make a new user returning their address.
 ```
 deal(address who, uint256 newBalance);
 ```
 Set a balance of the address o the newBalance;

For more information about the functions or finding others functions [here](https://book.getfoundry.sh/).

## Calculing the gas costs
In anvil, the default gas price is set to 0, so we neet to set it using this function.
```
function txGasPrice(uint256) external;
```

Now we have a function in solidity that calcul the gas left.
```
gasleft()
```
So we calcul the gas before and after the function that you want to calcul the gas.

## Storage optimization

The gas that you use accessing a storage(global) is a lot higher than accessing a local variables.

So every time we need to access a storage variable multiple time, we gonna put the value one time inside a local variable, so we can use the local variable.

## Foundry devops
[link](https://github.com/Cyfrin/foundry-devops)


## Summary
1. That is an official repo maintained by the same org
2. It downloads from the official release cycle `chainlink/contracts` use (npm) and packages it nicely for digestion from foundry.

# Thanks!

If you like this, follow me!