const {Contract} = require('ethers')

class RegistryContract extends Contract{
    constructor(verison){
        this.version = version;
        return new Proxy(this, {
            'get': (target,props,receiver) =>{
                const origMethod = target[prop]
                if( typeof origMethod == 'function'){
                    return (...args) => {
                        const fullArgs = [this.version, ...args]
                        return origMethod.apply(this,fullArgs)
                    }
                }
                return origMethod;
            }
        })
    }
    setVersion(newVersion){
        this.version = newVersion
    }
}


async function main(){
    console.log("executued")
    const MockRegistryTest = await new RegistryContract(39)
    console.log("deploy")
    const mockRegistryContract = await MockRegistryTest.deploy()
    console.log('randomAddress')
    let address = ethers.Wallet.createRandom().address
    await mockRegistryContract.test(address,100)
    console.log("Executed")
    //import MockRegistryTest via RegistryContract class 
    //Deploy 
    //Transact
}

if( require.main === module){
    console.log("Condition")
    main()//.then(process.exit(0)).catch( error =>{ console.log(error); process.exit(1)})
}
exports.RegistryContract = RegistryContract