checkPalindrome = function(){
    const palindromes=[]
    db.phones.find().forEach(function(doc){
        const prefix=doc.components.prefix
        const i=doc.components.number
        number= ((prefix * Math.pow(10, 9 - prefix.toString().length)) + i).toString();

        
        half_length=Math.floor(number.length/2)
        if(number.length%2==0){
            first_half=number.substring(0,half_length)
            second_half=number.substring(half_length).split("").reverse().join("")
        }else{
            first_half=number.substring(0,half_length)
            second_half=number.substring(half_length+1).split("").reverse().join("")
        }
        if(first_half===second_half){
            palindromes.push(number)
        }
    })
    return palindromes
}
