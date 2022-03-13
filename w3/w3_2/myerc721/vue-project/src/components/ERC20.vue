<script>
import { ethers } from 'ethers'

import myerc20Addr from '../../../deployments/dev/MyERC20.json'
import myerc20Abi from '../../../deployments/abi/MyERC20.json'

import vaultAddr from '../../../deployments/dev/Vault.json'
import vaultAbi from '../../../deployments/abi/Vault.json'

export default {

  name: 'erc20',

  data() {
    return {

      recipient: null,
      amount: null,
      balance: null,

      name: null,
      decimal: null,
      symbol: null,
      supply: null,

      mintAount: null,
      transferAmount: null,
      transferAccount: null,
      approveAmount: null,
      depositAmount: null,
      vaultAmount: null,
    }
  },

  async created() {
    await this.initAccount()
    this.initContract()
    this.getInfo();
    this.getNonce();
  },

  methods: {
    async initAccount(){
      if(window.ethereum) {
        console.log("initAccount");
        try{
          this.accounts = await window.ethereum.enable()
          console.log("accounts:" + this.accounts);
          this.account = this.accounts[0];
          this.currProvider = window.ethereum;
          this.provider = new ethers.providers.Web3Provider(window.ethereum);

          this.signer = this.provider.getSigner()
          let network = await this.provider.getNetwork()
          this.chainId = network.chainId;
          console.log("chainId:", this.chainId);

        } catch(error){
          console.log("User denied account access", error)
        }
      }else{
        console.log("Need install MetaMask")
      }
    },

    async initContract() {
      this.erc20Token = new ethers.Contract(myerc20Addr.address, 
        myerc20Abi, this.signer);

      this.vault = new ethers.Contract(vaultAddr.address, 
        vaultAbi, this.signer);
    }, 

    getInfo() {
      this.erc20Token.name().then((r) => {
        this.name = r;
      })
      this.erc20Token.decimals().then((r) => {
        this.decimal = r;
      })
      this.erc20Token.symbol().then((r) => {
        this.symbol = r;
      })
      this.erc20Token.totalSupply().then((r) => {
        this.supply = ethers.utils.formatUnits(r, 18);
      })

      this.erc20Token.balanceOf(this.account).then((r) => {
        this.balance = ethers.utils.formatUnits(r, 18);
      })
      
    },

    getNonce() {
      this.erc20Token.nonces(this.account).then(r => {
        this.nonce = r.toString();
        console.log("nonce:" + this.nonce);
      })
    },

    transfer() {
      let transferAmount = ethers.utils.parseUnits(this.transferAmount, 18);
      this.erc20Token.transfer(this.recipient, transferAmount).then((r) => {
        console.log(r);  // 返回值不是true
        this.getInfo();
      })
    },

    mint() {
      let mintAount = ethers.utils.parseUnits(this.mintAount, 18);
      this.erc20Token.mintToken(mintAount).then((r) => {
        console.log(r);  // 返回值不是true
        this.getInfo();
      })
    },

    approve() {
      let approveAmount = ethers.utils.parseUnits(this.approveAmount, 18);
      this.erc20Token.approve(this.account, approveAmount).then((r) => {
        console.log(r);  // 返回值不是true
        this.getInfo();
      })
    },

    deposit() {
      let depositAmount = ethers.utils.parseUnits(this.depositAmount, 18);
      this.vault.deposit(depositAmount).then((r) => {
        console.log(r);  // 返回值不是true
        this.getInfo();
      })
    },

    getDeposit() {
      console.log("getdeposit***********");
      this.vault.getDeposit(this.account).then((r) => {
        console.log(r); 
        this.vaultAmount = ethers.utils.formatUnits(r, 18);
      })
    },

    withdraw() {
      console.log("withdraw***********");
      this.vault.withdraw().then((r) => {
        console.log(r); 
      })
    },
  }

}


</script>

<template>
  <div >

      <div>
        <br /> 发行ERC20代币：
        <br /> Token名称 : {{ name  }}
        <br /> Token符号 : {{  symbol }}
        <br /> Token精度 : {{  decimal }}
        <br /> Token发行量 : {{  supply }}
        <br /> 我的账户 : {{ account  }}
        <br /> 我的余额 : {{ balance  }}
        <br /> 
        <input type="text" v-model="mintAount" />
        <button @click="mint()"> 铸币  </button>
      </div>

      <div >
        <br />转账到:
        <input type="text" v-model="recipient" />
        <br />转账金额
        <input type="text" v-model="transferAmount" />
        <br />
        <button @click="transfer()"> 转账 </button>
      </div>

      <div >
        <br /> Vault金库
        <br /> 
        <input type="text" v-model="approveAmount" />
        <button @click="approve()">授权</button>
        <br /> 
        <input type="text" v-model="depositAmount" />
        <button @click="deposit()">存款</button>
        <br /> 
        <button @click="getDeposit()">获取金库余额: </button> {{ vaultAmount  }}
        <br /> 

        <button @click="withdraw()">提取存款</button>
      </div>

  </div>
</template>

<style scoped>
h1 {
  font-weight: 500;
  font-size: 2.6rem;
  top: -10px;
}

h3 {
  font-size: 1.2rem;
}

.greetings h1,
.greetings h3 {
  text-align: center;
}

div {
  font-size: 1.2rem;
}

@media (min-width: 1024px) {
  .greetings h1,
  .greetings h3 {
    text-align: left;
  }
}
</style>
