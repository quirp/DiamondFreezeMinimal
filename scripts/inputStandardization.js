struct Freezable{
   
        state : boolean,
        parameterName : String,
        parameterType : String,
        externalContractSetter: String,
        internalGetter : String,
        libraryName : String,
        libraryGetter : String,
    
}
function inputStandardization(){
    
}

function alphabeticParameterOrdering(){
    //orders freezable array by name, mutates list
}
function fieldGrouping


class ContractState{
    
    constructor( contractFilepath){
        self.lines = processFile(contractFilepath)
    }
    
    async processFile(self, filePath) {
        const fileStream = fs.createReadStream(filePath);
    
        const rl = readline.createInterface({
            input: fileStream,
            crlfDelay: Infinity
        });
    
        let lines = [];
    
        for await (const line of rl) {
            // Each line in input.txt will be successively available here as `line`.
            lines.push(line);
        }
    
        return lines;
    }

}