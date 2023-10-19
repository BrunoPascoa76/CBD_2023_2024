populateJikan=async function(){
    db.jikan.drop()
    page=1
    let has_next_page=false
    do{
        print("page "+page)
        response = await fetch("https://api.jikan.moe/v4/seasons/2023/fall?sfw=&page="+page,{
            headers: {
                "Content-Type": "application/json"
            }
        })
        if(response.ok){
            responseJSON= await response.json()
            data=responseJSON.data
            db.jikan.insertMany(responseJSON.data)
            has_next_page=responseJSON.pagination.has_next_page 
            page+=1
        }else if(response.status==429){
            print("waiting because or rate limiting...")
            await sleep(3*1000) //we have a rate limit of 3 requests/second (and 60/minute)
        }else{
            return await response.json()
            errorMsg=await response.json().error
            throw new Error("Error while fetching from API: "+errorMsg)
        }
    }while(has_next_page)
    print("done!")
}