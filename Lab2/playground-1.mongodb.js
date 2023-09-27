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