use("cbd");

// 1. Liste todos os documentos da coleção.
db.restaurants.find()

// 2. Apresente os campos restaurant_id, nome, localidade e gastronomia para todos os documentos da coleção.
db.restaurants.find({},{_id: false, restaurant_id: true, nome: true, localidade: true, gastronomia: true})

// 3. Apresente os campos restaurant_id, nome, localidade e código postal (zipcode), mas exclua o campo _id de todos os documentos da coleção.
db.restaurants.find({},{_id: false, restaurant_id: true, nome: true, localidade: true, "address.zipcode": true})

// 4. Indique o total de restaurantes localizados no Bronx.
db.restaurants.find({localidade: 'Bronx'},{}).count()
// 309

// 5. Apresente os primeiros 15 restaurantes localizados no Bronx, ordenados por ordem crescente de nome.
db.restaurants.find({localidade: 'Bronx'},{}).sort({name: 1}).limit(15).count()

// 6. Liste todos os restaurantes que tenham pelo menos um score superior a 85.
db.restaurants.find({grades: {$elemMatch: {score: {$gt: 85}}}})

// 7. Encontre os restaurantes que obtiveram uma ou mais pontuações (score) entre [80 e 100].
db.restaurants.find({grades: {$elemMatch: {score: {$gte: 80, $lte: 100}}}})

// 8. Indique os restaurantes com latitude inferior a -95,7.
db.restaurants.find({"address.coord.0": {$lt: -95.7}})

// 9. Indique os restaurantes que não têm gastronomia "American", tiveram uma (ou mais) pontuação superior a 70 e estão numa latitude inferior a -65
db.restaurants.find({
  gastronomia: {$ne: "American"},
  grades: {$elemMatch: {score:{$gt: 70}}},
  "address.coord.0": {$lt:-65}
})

// 10. Liste o restaurant_id, o nome, a localidade e gastronomia dos restaurantes cujo nome começam por "Wil".
db.restaurants.find(
  {nome: /^Wil/},
  {
    _id: false,
    restaurant_id: true,
    nome: true,
    localidade: true,
    gastronomia: true
  }
)

// 11. Liste o nome, a localidade e a gastronomia dos restaurantes que pertencem ao Bronx e cuja gastronomia é do tipo "American" ou "Chinese".
db.restaurants.find(
  {
    localidade: 'Bronx',
    gastronomia: {$in: ["American","Chinese"]}
  },
  {
    _id: false,
    nome: true,
    localidade: true,
    gastronomia: true
  }
)

// 12. Liste o restaurant_id, o nome, a localidade e a gastronomia dos restaurantes localizados em "Staten Island", "Queens", ou "Brooklyn".
db.restaurants.find(
  {
    localidade: { $in: ["Staten Island","Queens","Brooklyn"] }
  },
  {
    _id: false,
    restaurant_id: true,
    nome: true,
    localidade: true,
    gastronomia: true
  }
)

//13. Liste o nome, a localidade, o score e gastronomia dos restaurantes que alcançaram sempre pontuações inferiores ou igual a 3.
db.restaurants.find(
  {
    grades: {$not: {$elemMatch: {score: {$gt: 3}}}}
  },
  {
    _id: false,
    nome: true,
    localidade: true,
    gastronomia: true
  }
)

// 14. Liste o nome e as avaliações dos restaurantes que obtiveram uma avaliação com um grade "A", um score 10 na data "2014-08-11T00: 00: 00Z" (ISODATE).
db.restaurants.find(
  {
    grades:
      {$elemMatch: {
        date: ISODate("2014-08-11T00:00:00Z"),
        score: 10,
        grade: "A"
      }}
  },
  {
    _id: false,
    nome: true,
    grades: true
  }
)

// 15. Liste o restaurant_id, o nome e os score dos restaurantes nos quais a segunda avaliação foi grade "A" e ocorreu em ISODATE "2014-08-11T00: 00: 00Z".
db.restaurants.find(
  {
    "grades.1.grade": "A",
    "grades.1.date": ISODate("2014-08-11T00:00:00Z")
  },
  {
    _id:false,
    restaurant_id:true,
    nome: true,
    "grades.score":true
  }
)

// 16. Liste o restaurant_id, o nome, o endereço (address) e as coordenadas geográficas (coord) dos restaurantes onde o 2º elemento da matriz de coordenadas tem um valor superior a 42 e inferior ou igual a 52.
db.restaurants.find(
  {
    "address.coord.1": {
      $gt:42,
      $lte: 52
    }
  },
  {
    _id:true,
    restaurant_id:true,
    nome:true,
    "address.rua": true,
    "address.coord":true
  }
)

// 17. Liste nome, gastronomia e localidade de todos os restaurantes ordenando por ordem crescente da gastronomia e, em segundo, por ordem decrescente de localidade.
db.restaurants.find(
  {},
  {
    _id:false,
    nome: true,
    gastronomia: true,
    localidade: true
  }
).sort(
  {
    gastronomia: 1,
    localidade: -1
  }
)

// 18. Liste nome, localidade, grade e gastronomia de todos os restaurantes localizados em Brooklyn que não incluem gastronomia "American" e obtiveram uma classificação (grade) "A". Deve apresentá-los por ordem decrescente de gastronomia.
db.restaurants.find(
  {
    localidade: "Brooklyn",
    gastronomia: {$ne: "American"},
    grades: {$elemMatch: {grade: "A"}}
  },
  {
    _id: false,
    nome: true,
    localidade: true,
    "grades.grade": true,
    gastronomia: true
  }
).sort({gastronomia:-1})

// 19. Indique o número total de avaliações (numGrades) na coleção
db.restaurants.aggregate([
  {$unwind: "$grades"},
  {$count: "numGrades"}
])

// 20. Apresente o nome e número de avaliações (numGrades) dos 3 restaurante com mais avaliações.
db.restaurants.aggregate([
  {$group: {
    _id:"$nome",
    numGrades: {$sum: {$size:"$grades"}}
  }},
  {$sort:{numGrades: 1}},
  {$limit: 3}
])

// 21. Apresente o número total de avaliações (numGrades) em cada dia da semana.
db.restaurants.aggregate([
  {$unwind: "$grades"},
  {$group:{
    _id: {$dayOfWeek: "$grades.date"},
    numGrades: {$count: {}}
  }},
  {$sort: {_id:1}}
])

// 22. Conte o total de restaurante existentes em cada localidade.
db.restaurants.aggregate([
  {$group:{
    _id: "$localidade",
    numRestaurantes: {$count: {}}
  }}
])

// 23. Indique os restaurantes que têm gastronomia "Portuguese", o somatório de score é superior a 50 e estão numa latitude inferior a -60.
db.restaurants.aggregate([
  {$project: {
    nome:"$nome",
    totalScore: {$sum: "$grades.score"},
    address:"$address",
    gastronomia: "$gastronomia"
  }},
  {$match: {
    gastronomia: "Portuguese",
    "address.coord.0": {$lt: -60}
  }},
])

// 24. Apresente o número de gastronomias diferentes na rua "Fifth Avenue"
db.restaurants.aggregate([
  {$match: {
    "address.rua": "Fifth Avenue"
  }},
  {$group:{
    _id: "$address.rua",
    distinctGastronomias: {$addToSet: "$gastronomia"}
  }},
  {$project: {
    _id: "$_id",
    numGastronomias: {$size: "$distinctGastronomias"}
  }}
])

// 25. Apresente o nome e o score médio (avgScore) e número de avaliações (numGrades) dos restaurantes com score médio superior a 30 desde 1-Jan-2014.
db.restaurants.aggregate([
  {$unwind: "$grades"},
  {$group: {
    _id:"$nome",
    avgScore: {$avg: "$grades.score"},
    numGrades: {$count: {}},
    scoresSinceJan: {$push: {$cond: [
      {$gte: ["$grades.date",ISODate("2014-01-01T00:00:00Z")]},
      {"score": "$grades.score"},
      "$$REMOVE"
    ]}}
  }},
  {$project: {
    _id:"$_id",
    avgScore: "$avgScore",
    numGrades: "$numGrades",
    scoresSinceJanAvg: {$avg: "$scoresSinceJan.score"}
  }},
  {$match:{
    scoresSinceJanAvg: {$gt: 30}
  }}
])

//26. Liste o score médio por localidade
db.restaurants.aggregate([
  {$unwind: "$grades"},
  {$group: {
    _id: "$localidade",
    avgScore: {$avg: "$grades.score"}
  }}
])

//27. Para cada restaurante (nome), para cada grade, obter o número de avaliações e o score médio, ordenado por nome e grade (respetivamente)
db.restaurants.aggregate([
  {$unwind: "$grades"},
  {$group: {
    _id:{
      nome: "$nome",
      grade: "$grades.grade"
    },
    numGrades: {$count: {}},
    avgScore: {$avg: "$grades.score"}
  }}
]).sort({
  "_id.nome": 1,
  "_id.grade": 1
})

//28. Procurar por restaurante cujo nome contenha 'restaurant' (case-insensitive)
db.restaurants.find({
  nome: {
    $regex: '.*restaurant.*',
    $options: 'si'
  }
})

//29. Obter histograma de scores
db.restaurants.aggregate([
  {$unwind: "$grades"},
  {$bucketAuto: {
    groupBy: "$grades.score",
    buckets: 10
  }}
])

//30. Ordenar restaurantes por ordem crescente de distância à posição atual (assume que estamos nas coordenadas 1,1)
db.restaurants.aggregate([
  {$project: {
    _id:"$_id",
    nome:"$nome",
    distancia: {$sqrt: {$sum: [
      {$pow:[
        {$subtract: [
          {$arrayElemAt:["$address.coord",0]},1]
        },2
      ]},
      {$pow:[
        {$subtract: [
          {$arrayElemAt:["$address.coord",1]},1]
        },2
      ]}
    ]}}
  }}
]).sort({distancia: 1})