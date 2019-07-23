
Mongo DB configuration command
==============================
    rails generate mongoid:config

Rails Console mongoid examples
==============================
    > Get Mongo Client, database and collection info
    > ==============================================

        irb(main):009:0> mongo_client = Mongoid::Clients.default
        => #<Mongo::Client:0x70219403678980 cluster=#<Cluster topology=Single[localhost:27017] servers=[#<Server address=localhost:27017 STANDALONE>]>>

        irb(main):010:0> mongo_client.database.name
        => "zips_development"

        irb(main):011:0> collection=mongo_client[:zips]
        => #<Mongo::Collection:0x70219394845320 namespace=zips_development.zips>

        irb(main):012:0> collection.count
        MONGODB | localhost:27017 | zips_development.count | STARTED | {"count"=>"zips", "query"=>{}, "lsid"=>{"id"=><BSON::Binary:0x70219405326140 type=uuid data=0x2f1bb2b86cca45ee...>}}
        MONGODB | localhost:27017 | zips_development.count | SUCCEEDED | 0.001s
        => 29353

    > rails generate scaffold_controller Zip id city state population:integer

