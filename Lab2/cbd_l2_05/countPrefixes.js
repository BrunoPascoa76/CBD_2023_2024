countPrefixes = function() {
    return db.phones.aggregate([
        {$group:{
            _id:"$components.prefix",
            _totalNumbers: {$count: {}}
        }}
    ])
}