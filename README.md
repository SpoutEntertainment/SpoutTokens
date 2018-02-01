# SpoutTokens

### Prerequisite

  - NodeJS >= 8.5.0

### Installation

1. Install [truffle](https://github.com/trufflesuite/truffle)

`$ npm install -g truffle`

2. Compile contracts

```sh
// clone this repo first
$ cd /path/to/project
$ truffle compile
```

3. Deploy

  - Development env

    + Install [ganacache](https://github.com/trufflesuite/ganache)
    + Start ganache
    + Run `$ truffle migrate --network development`

  - Testnet env

    + Install [geth](https://github.com/ethereum/go-ethereum/wiki/geth)
    + Install [Ethereum wallet](https://github.com/ethereum/mist/releases)
    + Run
    ```sh
    $ mkdir -p $HOME/.rinkeby
    $ geth --datadir=$HOME/.rinkeby --rinkeby
    ```
    + Open new cmd, run (MacOS only) `$ /Application/Ethereum\ Wallet.app/Contents/MacOS/Ethereum\ Wallet --rpc $HOME/.rinkeby/geth.ipc`, then create some new accounts
    + Wait for syncing...
    + When syncing done, run `$ geth --datadir=$HOME/.rinkeby --rinkeby --rpc --rpcapi db,eth,net,web3,personal`
    + Open new cmd, run
    ```sh
    $ geth attach $HOME/.rinkeby/geth.ipc`
    $ personal.unlockAccount(eth.accounts[0])
    ```
    + Open new cmd, run `$ truffle migrate --network rinkeby`

#### Deployed contract at Rinkeby

  - Contract address: `0x8155c5bDDBE64Fb9469F335A6aFF3345725f8aA2`

### Helpful links

  - https://github.com/ethereum/wiki/wiki/JSON-RPC
  - http://www.ethdocs.org/en/latest/contracts-and-transactions/accessing-contracts-and-transactions.html
