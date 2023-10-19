## Exercício 6
Neste exercício vai ser utilizado dados obtidos através da API pública Jikan (documentação da API: <https://docs.api.jikan.moe>)
Jikan é uma API não oficial de MyAnimeList para obter dados sobre animes, manga, etc. Devido a limitações de taxa de acesso, o dataset vai ser restringido aos animes desta época (fall 2023).

Cada anime segue a seguinte estrutura JSON (campos não necessários foram omitidos para simplificar):

```json
{
    mal_id: 0,
    english_title: string,
    japanese_title: string,
    status: string,
    score: 0.0,
    type: string
    titles: [
        {
            type: string,
            title: string
        }
    ],
    genres: [
        {
            mal_id: 0
            type: string
            name: string
            url: string
        }
    ]
}
```

Nota: animes com informação incompleta (sem um score atribuido, por exemplo, terão valor null nessa entrada)

a) Copie o ficheiro populateJikan.js para uma pasta da sua área de trabalho. Arranque o cliente mongo e descarregue no servidor a função "populateJikan". Analise e teste o funcionamento desta função.

```javascript
> load("<pasta da sua área de trabalho>/populateJikan.js")
true
> populateJikan
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

> populateJikan()
page 1
page 2
page 3
page 4
page 5
waiting because or rate limiting...
page 5
done!
```

*(Nota: carrega na “current shell”. Não armazena no servidor)*

(Nota: esta operação não é imediata).  

b) No final, verifique o conteúdo da coleção (usando as funções find, count, ...).

c) Utilize find() para obter os seguintes resultados:

* I) Liste os campos mal_id, title_english, title_japanese, status e score para todos os documentos da coleção.  
Resposta:

    ```javascript
    db.jikan.find({},{
        _id:false,
        mal_id: true,
        title_english: true,
        title_japanese: true,
        status: true,
        score: true
    })
    ```

* II) Liste os campos referidos anteriormente para todas as séries (type TV).  
Resposta:

    ```javascript
    db.jikan.find({type:"TV"},{
        _id:false,
        mal_id: true,
        title_english: true,
        title_japanese: true,
        status: true,
        score: true
    })
    ```

* III) Obtenha todos os animes com um score pertence ao intervalo ]7,9].  
Resposta:

    ```javascript
    db.jikan.find({
        score: {$gt: 7, $lte: 9}
    },{
        _id:false,
        mal_id: true,
        title_english: true,
        title_japanese: true,
        status: true,
        score: true
    })
    ```

* IV) Obtenha todos os animes que não são de ação.  
Resposta:

    ```javascript
    db.jikan.find({
        genres: {$not:{$elemMatch: {name: "Action"}}}
    },{
        _id:false,
        mal_id: true,
        title_english: true,
        title_japanese: true,
        status: true,
        genres: true,
        score: true
    })
    ```

* V) Ordene os animes por ordem decrescente de score.  
Resposta:

    ```javascript
    db.jikan.find({},{
        _id:false,
        mal_id: true,
        title_english: true,
        title_japanese: true,
        status: true,
        score: true
    }).sort({score: -1})
    ```

* VI) Crie uma função em javascript que permite pesquisar animes por nome. Crie os índices que considerar necessário.
(Pontos bónus se o aluno ordenar por relevância)
Resposta:

    ```javascript
    
    db.jikan.createIndex({
        title_english: "text",
        title_japanese: "text",
        "titles.title": "text"
    })

    //sem ordenação:
    searchAnime= function(name){
        return db.jikan.find({
            $text: {$search: "*"+name+"*"}
        },{
            _id:false,
            mal_id: true,
            title_english: true,
            title_japanese: true,
            status: true,
            score:true
        })
    }
    
    //com ordenação:
    searchAnime= function(name){
        return db.jikan.find({
            $text: {$search: "*"+name+"*"}
        },{
            _id:false,
            mal_id: true,
            title_english: true,
            title_japanese: true,
            status: true,
            score:true,
            relevance: {$meta: "textScore"}
        }).sort({relevance: {$meta: "textScore"}})
    }
    ```

d) Utilize as funções de agregação para obter os seguintes resultados:

* I) Para cada género (genre), obter o nome (name), o número de animes neste época e o score médio.  
Resposta:

    ```javascript
    db.jikan.aggregate([
        {$unwind: "$genres"},
        {$group: {
            _id:"$genres.name",
            animeCount: {$count: {}},
            averageScore: {$avg: "$score"}
        }}
    ])
    ```

* II) obtenha o score médio.  
Resposta:

    ```javascript
    db.jikan.aggregate([
        {$group:{
            _id:null,
            averageScore: {$avg: "$score"}
        }}
    ])
    ```

* III) Obtenha o número total de géneros das séries (sem repetições).
Resposta:

    ```javascript
    db.jikan.aggregate([
        {$match: {type: "TV"}},
        {$unwind: "$genres"},
        {$group: {
            _id: null,
            genres: {$addToSet: "$genres"}
        }},
        {$project: {
            numGenres: {$size: "$genres"}
        }}
    ])
    ```

* IV) obtenha o número de géneros dos 3 animes com melhor score.  
Resposta:

    ```javascript
    db.jikan.aggregate([
        {$unwind: "$genres"},
        {$group:{
            _id: {
                mal_id: "$mal_id",
                english_title: "$english_title",
                japanese_title: "$japanese_title",
                score: "$score"
            },
            numGenres: {$count: {}}
        }},
        {$sort: {"_id.score": -1}},
        {$limit: 3}
    ])
    ```

* V) para cada type, para cada genre, obter o score médio.  
Resposta:

    ```javascript
    db.jikan.aggregate([
        {$unwind: "$genres"},
        {$group:{
            _id: {
                type: "$type",
                genre: "$genres.name"
            },
            averageScore: {$avg: "$score"}
        }}
    ])
    ```

* VI) obter um histograma das scores (10 buckets).  
Resposta:

    ```javascript
    db.jikan.aggregate([
        {$bucketAuto: {
            groupBy: "$score",
            buckets: 10
        }}
    ])
    ```
