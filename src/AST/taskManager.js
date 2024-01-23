
class TaskManager{
    constructor(AST,mainContractName){
        this.AST = AST
    }
    isParent(freezeableInitializorContractName){
        const _isParent = (tree) =>{
            for( const node of tree){
                if( node.type == 'ContractDefinition' && node.name == freezeableInitializorContractName ){
                    if(node.subnodes && node.subnodes.length > 0){
                        for(subnode of node.subnodes){
                            if(subnode.type == 'StateVariableDeclaration' ){
                                //Unsure how the grammar would allow variables length > 1
                                if(subnode.variables && subnode.variables.length >= 1){
                                    for( variable of subnode.variables){
                                        
                                    }
                                }
                            }
                            if( subnode.type == "FunctionDefinition"){  

                            }
                        }
                    }
                }
            }
            throw Error(`FreezeableInitializorContractName - ${parentContractName} does
            not exist in ${this.mainContractName}.`)
        }   
        return _isParent(this.AST.children)
    }
    freezeableExists(freezeableName){
        const _freezeableExists = (tree) =>{
            for( const node of tree){
                if( node.type == 'ContractDefinition' && node.name == contractName ){
                    return true;
                }
                if (node.children && node.children.length > 0){
                    if( _isParent(node.children)){
                        return true
                    }
                }
            }
            return false;
        }   
        return _freezeableExists(this.AST.children)
    }
   
}
class Freezeable{
    constructor(freezeable){
        this.name = freezeable.name
        this.isFrozen = freezeable.isFrozen 
        this.contractContainers = freezeable.contractContainers
    }

    
}
module.exports = {TaskManager}

/**
 * Two different operations:
* 1. Transform
* 2. Set

Setting will implement the freezeables as if it were in an uninstantiated state. 
There's no changes other than instantating a transformation. 
It will look to transform it and throw an error if there is conflict
 */