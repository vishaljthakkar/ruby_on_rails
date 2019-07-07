1. Seed mongodb with the data
=============================
    # Downloaded mongodb data from the following location
    http://media.mongodb.org/zips.json

    # Ran following command to seed mongodb
        > mongoimport --db test --collection zips --drop --file zips.json


    # Command to create capped collection in mongo. 
     # log collection with 5K entries of size 5 MB fixed. 5001 and 5002 entry overwrites 1st and 2nd entry.
        > db.createCollection("log", { capped: true, size: 5242880, max: 5000})

2. IRB mongo example inside project
===================================
    2.1: We need this gem
    =====================

        irb(main):001:0> require 'mongo'
            => true
        irb(main):002:0> print "Configure mongo logging to INFO level"
        Configure mongo logging to INFO level=> nil
        irb(main):003:0> Mongo::Logger.logger.level = ::Logger::INFO
            => 1
        
        Establish mongo client
        ======================
        irb(main):004:0> db = Mongo::Client.new('mongodb://localhost:27017')
            => #<Mongo::Client:0x70157930214700 cluster=#<Cluster topology=Single[localhost:27017] servers=[#<Server address=localhost:27017 STANDALONE>]>>

        Use database 'test'
        ==================
        irb(main):007:0> db = db.use('test')
            => #<Mongo::Client:0x70157905405080 cluster=#<Cluster topology=Single[localhost:27017] servers=[#<Server address=localhost:27017 STANDALONE>]>>
        irb(main):010:0> db.database.name
            => "test"
        irb(main):013:0> db.database.collection_names
            => ["zips"]

        find.first
        ==========
        irb(main):016:0> db[:zips].find.first
            => {"_id"=>"01001", "city"=>"AGAWAM", "loc"=>[-72.622739, 42.070206], "pop"=>15338, "state"=>"MA"}

        insert_one
        ==========
            irb(main):037:0> db[:zips].insert_one(:_id => "100", :city => "city01", :loc => [76.05, 55,55], :pop => 4678, :state => "CA")
            irb(main):039:0> db[:zips].find({:_id => '100'}).count
                => 1
            irb(main):040:0> db[:zips].find({:_id => '100'}).class
                => Mongo::Collection::View
            irb(main):043:0> db[:zips].find({:_id => '100'}).to_a
                => [{"_id"=>"100", "city"=>"city01", "loc"=>[76.05, 55, 55], "pop"=>4678, "state"=>"CA"}]

        insert_many
        ===========
            irb(main):044:0> db[:zips].insert_many([
            irb(main):045:2*  { :_id => "200", :city => "city02",:loc => [ -74.05922700000001, 37.564894 ],:pop => 2000, :state => "CA" },
            irb(main):046:2*  { :_id => "201", :city => "city03",:loc => [ -75.05922700000001,35.564894 ], :pop => 3000, :state => "CA" }
            irb(main):048:2> ])
                => #<Mongo::BulkWrite::Result:0x00007fe46ec32710 @results={"n_inserted"=>2, "n"=>2, "inserted_ids"=>["200", "201"]}>
            irb(main):049:0> db[:zips].find(:city => 'city02').count
                => 1
            irb(main):050:0> db[:zips].find(:city => 'city03').count
                => 1
            irb(main):051:0> db[:zips].find(:city => 'city02').to_a
                => [{"_id"=>"200", "city"=>"city02", "loc"=>[-74.059227, 37.564894], "pop"=>2000, "state"=>"CA"}]
            irb(main):052:0> db[:zips].find(:city => 'city03').to_a
                => [{"_id"=>"201", "city"=>"city03", "loc"=>[-75.059227, 35.564894], "pop"=>3000, "state"=>"CA"}]

        find by example
        ===============
            irb(main):071:0> db[:zips].find(:city => "BALTIMORE")
            => #<Mongo::Collection::View:0x70309572156260 namespace='test.zips' @filter={"city"=>"BALTIMORE"} @options={}>
            irb(main):072:0> db[:zips].find(:city => "BALTIMORE").count
            => 22
            irb(main):073:0>
            irb(main):074:0> db[:zips].find.first
            => {"_id"=>"01001", "city"=>"AGAWAM", "loc"=>[-72.622739, 42.070206], "pop"=>15338, "state"=>"MA"}
            irb(main):075:0> db[:zips].find.first.class
            => BSON::Document
            irb(main):076:0>
            irb(main):077:0> db[:zips].find(:state => "MD").first
            => {"_id"=>"20331", "city"=>"ANDREWS AFB", "loc"=>[-76.886695, 38.800324], "pop"=>10228, "state"=>"MD"}
            irb(main):078:0> db[:zips].find(:state => "MD").count
            => 420
        
        Distinct and alternate to hash-rocket way of querying
        =====================================================
            irb(main):079:0> db[:zips].find.distinct(:state)
            => ["MA", "RI", "NH", "ME", "VT", "CT", "NY", "NJ", "PA", "DE", "DC", "MD", "VA", "WV", "NC", "SC", "GA", "FL", "AL", "TN", "MS", "KY", "OH", "IN", "MI", "IA", "WI", "MN", "SD", "ND", "MT", "IL", "MO", "KS", "NE", "LA", "AR", "OK", "TX", "CO", "WY", "ID", "UT", "AZ", "NM", "NV", "CA", "HI", "OR", "WA", "AK"]
            irb(main):080:0>
            irb(main):081:0>
            irb(main):082:0> db[:zips].find(city: 'GERMANTOWN').count
            => 8
            irb(main):083:0> db[:zips].find(city: 'GERMANTOWN').first
            => {"_id"=>"12526", "city"=>"GERMANTOWN", "loc"=>[-73.862451, 42.1219], "pop"=>4061, "state"=>"NY"}
            irb(main):084:0> db[:zips].find(:city => 'GERMANTOWN').first
            => {"_id"=>"12526", "city"=>"GERMANTOWN", "loc"=>[-73.862451, 42.1219], "pop"=>4061, "state"=>"NY"}
            irb(main):086:0> db['zips'].find(:city => 'GERMANTOWN').first
            => {"_id"=>"12526", "city"=>"GERMANTOWN", "loc"=>[-73.862451, 42.1219], "pop"=>4061, "state"=>"NY"}

        Pretty Print and Enumeration
        ============================
           irb(main):089:0> require 'pp'
            => true
            irb(main):090:0> pp db[:zips].find(:city => "GERMANTOWN", :state => "NY").first
            {"_id"=>"12526",
             "city"=>"GERMANTOWN",
             "loc"=>[-73.862451, 42.1219],
             "pop"=>4061,
             "state"=>"NY"}
            => {"_id"=>"12526", "city"=>"GERMANTOWN", "loc"=>[-73.862451, 42.1219], "pop"=>4061, "state"=>"NY"}
            irb(main):091:0> pp db[:zips].find(:city => "GERMANTOWN", :state => "MD").first
            {"_id"=>"20876",
             "city"=>"GERMANTOWN",
             "loc"=>[-77.235829, 39.188001],
             "pop"=>11734,
             "state"=>"MD"}
            => {"_id"=>"20876", "city"=>"GERMANTOWN", "loc"=>[-77.235829, 39.188001], "pop"=>11734, "state"=>"MD"}
            irb(main):092:0>
            irb(main):093:0>
            irb(main):094:0>
            irb(main):095:0> db[:zips].find().each { |r| puts r }
            {"_id"=>"01001", "city"=>"AGAWAM", "loc"=>[-72.622739, 42.070206], "pop"=>15338, "state"=>"MA"}
            {"_id"=>"01026", "city"=>"CUMMINGTON", "loc"=>[-72.905767, 42.435296], "pop"=>1484, "state"=>"MA"}
            {"_id"=>"01028", "city"=>"EAST LONGMEADOW", "loc"=>[-72.505565, 42.067203], "pop"=>13367, "state"=>"MA"}

        Projections/ pluck
        ==================
            irb(main):101:0> db[:zips].find({:state => "MD"}).projection(state: true, _id: false).first
            => {"state"=>"MD"}

        Limit
        =====
            irb(main):107:0> db[:zips].find.limit(3).each { |r| p r}
            {"_id"=>"01001", "city"=>"AGAWAM", "loc"=>[-72.622739, 42.070206], "pop"=>15338, "state"=>"MA"}
            {"_id"=>"01026", "city"=>"CUMMINGTON", "loc"=>[-72.905767, 42.435296], "pop"=>1484, "state"=>"MA"}
            {"_id"=>"01028", "city"=>"EAST LONGMEADOW", "loc"=>[-72.505565, 42.067203], "pop"=>13367, "state"=>"MA"}

        Skip , Limit
        ============
            irb(main):115:0> db[:zips].find.skip(3).limit(3).each { |r| puts r}
            {"_id"=>"01030", "city"=>"FEEDING HILLS", "loc"=>[-72.675077, 42.07182], "pop"=>11985, "state"=>"MA"}
            {"_id"=>"01027", "city"=>"MOUNT TOM", "loc"=>[-72.679921, 42.264319], "pop"=>16864, "state"=>"MA"}
            {"_id"=>"01002", "city"=>"CUSHMAN", "loc"=>[-72.51565, 42.377017], "pop"=>36963, "state"=>"MA"}
            => #<Enumerator: #<Mongo::Cursor:0x70309537501540 @view=#<Mongo::Collection::View:0x70309537551580 namespace='test.zips' @filter={} @options={"skip"=>3, "limit"=>3}>>:each>
            irb(main):116:0>

        Sort, Asc
        =========
            irb(main):117:0> db[:zips].find.limit(3).sort({:city => 1 }).each { |r| p r}
            {"_id"=>"42601", "city"=>"AARON", "loc"=>[-85.199114, 36.812827], "pop"=>270, "state"=>"KY"}
            {"_id"=>"16820", "city"=>"AARONSBURG", "loc"=>[-77.387977, 40.876944], "pop"=>100, "state"=>"PA"}
            {"_id"=>"31794", "city"=>"ABAC", "loc"=>[-83.498867, 31.451722], "pop"=>27906, "state"=>"GA"}
            => #<Enumerator: #<Mongo::Cursor:0x70309511731780 @view=#<Mongo::Collection::View:0x70309511782280 namespace='test.zips' @filter={} @options={"limit"=>3, "sort"=>{"city"=>1}}>>:each>
            irb(main):118:0>

        Sort, Desc
        ==========
            irb(main):118:0> db[:zips].find.limit(3).sort({:city => -1 }).each { |r| p r}
            {"_id"=>"201", "city"=>"city03", "loc"=>[-75.059227, 35.564894], "pop"=>3000, "state"=>"CA"}
            {"_id"=>"200", "city"=>"city02", "loc"=>[-74.059227, 37.564894], "pop"=>2000, "state"=>"CA"}
            {"_id"=>"100", "city"=>"city01", "loc"=>[76.05, 55, 55], "pop"=>4678, "state"=>"CA"}
            => #<Enumerator: #<Mongo::Cursor:0x70309511338580 @view=#<Mongo::Collection::View:0x70309511388400 namespace='test.zips' @filter={} @options={"limit"=>3, "sort"=>{"city"=>-1}}>>:each>
        find less and greater than
        ==========================
            irb(main):125:0> db[:zips].find(:city => {:$lt => 'D'}).limit(2).to_a.each { |r| p r }
            {"_id"=>"01001", "city"=>"AGAWAM", "loc"=>[-72.622739, 42.070206], "pop"=>15338, "state"=>"MA"}
            {"_id"=>"01026", "city"=>"CUMMINGTON", "loc"=>[-72.905767, 42.435296], "pop"=>1484, "state"=>"MA"}

            irb(main):129:0> db[:zips].find(:city => {:$gt => 'AB', :$lt => 'AD'}).limit(10).to_a.each { |r| p r };nil
            {"_id"=>"01720", "city"=>"ACTON", "loc"=>[-71.448255, 42.475076], "pop"=>15514, "state"=>"MA"}
            {"_id"=>"02351", "city"=>"ABINGTON", "loc"=>[-70.954293, 42.116715], "pop"=>13849, "state"=>"MA"}
            {"_id"=>"02743", "city"=>"ACUSHNET", "loc"=>[-70.908652, 41.6997], "pop"=>9601, "state"=>"MA"}
            {"_id"=>"04001", "city"=>"ACTON", "loc"=>[-70.930687, 43.549405], "pop"=>767, "state"=>"ME"}
            {"_id"=>"04406", "city"=>"ABBOT VILLAGE", "loc"=>[-69.52514, 45.279838], "pop"=>1193, "state"=>"ME"}
            {"_id"=>"12404", "city"=>"ACCORD", "loc"=>[-74.235336, 41.808308], "pop"=>2695, "state"=>"NY"}
            {"_id"=>"12405", "city"=>"ACRA", "loc"=>[-74.085723, 42.330367], "pop"=>525, "state"=>"NY"}
            {"_id"=>"15610", "city"=>"ACME", "loc"=>[-79.482747, 40.104891], "pop"=>3862, "state"=>"PA"}
            {"_id"=>"17301", "city"=>"ABBOTTSTOWN", "loc"=>[-76.993077, 39.888099], "pop"=>1777, "state"=>"PA"}
            {"_id"=>"20606", "city"=>"ABELL", "loc"=>[-76.744104, 38.249554], "pop"=>601, "state"=>"MD"}
            => nil

        find with regex
        ===============
            irb(main):131:0> db[:zips].find(:city => {:$regex => 'X'}).limit(5).each {|r| p r};nil
            {"_id"=>"01240", "city"=>"LENOX", "loc"=>[-73.271322, 42.364241], "pop"=>5001, "state"=>"MA"}
            {"_id"=>"01537", "city"=>"NORTH OXFORD", "loc"=>[-71.885953, 42.16549], "pop"=>3031, "state"=>"MA"}
            {"_id"=>"01540", "city"=>"OXFORD", "loc"=>[-71.868677, 42.11285], "pop"=>9557, "state"=>"MA"}
            {"_id"=>"01569", "city"=>"UXBRIDGE", "loc"=>[-71.632869, 42.074426], "pop"=>10364, "state"=>"MA"}
            {"_id"=>"01612", "city"=>"PAXTON", "loc"=>[-71.920234, 42.306646], "pop"=>4047, "state"=>"MA"}

            irb(main):134:0> db[:zips].find(:city => {:$regex => 'X$'}).limit(5).each {|r| p r};nil
            {"_id"=>"01240", "city"=>"LENOX", "loc"=>[-73.271322, 42.364241], "pop"=>5001, "state"=>"MA"}
            {"_id"=>"01929", "city"=>"ESSEX", "loc"=>[-70.782794, 42.628629], "pop"=>3260, "state"=>"MA"}
            {"_id"=>"02338", "city"=>"HALIFAX", "loc"=>[-70.844794, 42.000159], "pop"=>6526, "state"=>"MA"}
            {"_id"=>"05358", "city"=>"WEST HALIFAX", "loc"=>[-72.750142, 42.776103], "pop"=>202, "state"=>"VT"}
            {"_id"=>"05454", "city"=>"FAIRFAX", "loc"=>[-73.024078, 44.692387], "pop"=>2990, "state"=>"VT"}
            => nil
            
            irb(main):135:0> db[:zips].find(:city => {:$regex => '^X'}).projection({:_id => false}).limit(5).to_a.each {|r| p r}
            {"city"=>"XENIA", "loc"=>[-83.936878, 39.684204], "pop"=>36683, "state"=>"OH"}
            {"city"=>"XENIA", "loc"=>[-88.63789, 38.669747], "pop"=>1252, "state"=>"IL"}
            => [{"city"=>"XENIA", "loc"=>[-83.936878, 39.684204], "pop"=>36683, "state"=>"OH"}, {"city"=>"XENIA", "loc"=>[-88.63789, 38.669747], "pop"=>1252, "state"=>"IL"}]

            irb(main):137:0> db[:zips].find(:city => {:$regex => '^[A-E]'}).projection({:_id => false}).limit(5).to_a.each {|r| p r};nil
            {"city"=>"AGAWAM", "loc"=>[-72.622739, 42.070206], "pop"=>15338, "state"=>"MA"}
            {"city"=>"CUMMINGTON", "loc"=>[-72.905767, 42.435296], "pop"=>1484, "state"=>"MA"}
            {"city"=>"EAST LONGMEADOW", "loc"=>[-72.505565, 42.067203], "pop"=>13367, "state"=>"MA"}
            {"city"=>"CUSHMAN", "loc"=>[-72.51565, 42.377017], "pop"=>36963, "state"=>"MA"}
            {"city"=>"CHICOPEE", "loc"=>[-72.576142, 42.176443], "pop"=>31495, "state"=>"MA"}

        find with exists, if attribute exists
        =====================================
            irb(main):141:0> db[:zips].find(:city => {:$exists => true}).projection({:_id => false}).limit(3).to_a.each {|r| p r};nil
            {"city"=>"AGAWAM", "loc"=>[-72.622739, 42.070206], "pop"=>15338, "state"=>"MA"}
            {"city"=>"CUMMINGTON", "loc"=>[-72.905767, 42.435296], "pop"=>1484, "state"=>"MA"}
            {"city"=>"EAST LONGMEADOW", "loc"=>[-72.505565, 42.067203], "pop"=>13367, "state"=>"MA"}

        find by not
        ===========
            irb(main):143:0> db[:zips].find(:pop => {'$not' => {'$gt' => 9500}}).projection({_id:false}).limit(20).to_a.each {|r| p r};nil
            {"city"=>"CUMMINGTON", "loc"=>[-72.905767, 42.435296], "pop"=>1484, "state"=>"MA"}
            {"city"=>"GOSHEN", "loc"=>[-72.844092, 42.466234], "pop"=>122, "state"=>"MA"}
            {"city"=>"GILBERTVILLE", "loc"=>[-72.198585, 42.332194], "pop"=>2385, "state"=>"MA"}
            {"city"=>"TOLLAND", "loc"=>[-72.908793, 42.070234], "pop"=>1652, "state"=>"MA"}
            {"city"=>"HADLEY", "loc"=>[-72.571499, 42.36062], "pop"=>4231, "state"=>"MA"}
            {"city"=>"GRANBY", "loc"=>[-72.520001, 42.255704], "pop"=>5526, "state"=>"MA"}
            {"city"=>"HAMPDEN", "loc"=>[-72.431823, 42.064756], "pop"=>4709, "state"=>"MA"}
            {"city"=>"HATFIELD", "loc"=>[-72.616735, 42.38439], "pop"=>3184, "state"=>"MA"}
            {"city"=>"HAYDENVILLE", "loc"=>[-72.703178, 42.381799], "pop"=>1387, "state"=>"MA"}
            {"city"=>"HUNTINGTON", "loc"=>[-72.873341, 42.265301], "pop"=>2084, "state"=>"MA"}
            {"city"=>"MONSON", "loc"=>[-72.319634, 42.101017], "pop"=>8194, "state"=>"MA"}
            {"city"=>"CHESTERFIELD", "loc"=>[-72.833309, 42.38167], "pop"=>177, "state"=>"MA"}
            {"city"=>"LEEDS", "loc"=>[-72.703403, 42.354292], "pop"=>1350, "state"=>"MA"}
            {"city"=>"BLANDFORD", "loc"=>[-72.936114, 42.182949], "pop"=>1240, "state"=>"MA"}
            {"city"=>"BRIMFIELD", "loc"=>[-72.188455, 42.116543], "pop"=>3706, "state"=>"MA"}
            {"city"=>"WESTOVER AFB", "loc"=>[-72.558657, 42.196672], "pop"=>1764, "state"=>"MA"}
            {"city"=>"BARRE", "loc"=>[-72.108354, 42.409698], "pop"=>4546, "state"=>"MA"}
            {"city"=>"CHESTER", "loc"=>[-72.988761, 42.279421], "pop"=>1688, "state"=>"MA"}
            {"city"=>"LEVERETT", "loc"=>[-72.499334, 42.46823], "pop"=>1748, "state"=>"MA"}
            {"city"=>"OAKHAM", "loc"=>[-72.051265, 42.348033], "pop"=>1503, "state"=>"MA"}

        find by type # Type here is a BSON type (https://docs.mongodb.com/manual/reference/bson-types/)
        ============
            irb(main):144:0> db[:zips].find({:state=> {:$type => 2}}).first
            => {"_id"=>"01001", "city"=>"AGAWAM", "loc"=>[-72.622739, 42.070206], "pop"=>15338, "state"=>"MA"}

        replace_one
        ===========

            # first-add a new city (:city => "citytemp")
                db[:zips].insert_one(:_id => "100", :city => "citytemp", :loc => [ -76.05922700000001, 39.564894 ], :pop => 4678, :state => "MD" )


            # check the insertion
                db[:zips].find(:city => 'citytemp').first

            # replace city name from 'citytemp' to 'city02'
                db[:zips].find(:_id => "100").replace_one(:_id => "100", :city => "city02", :loc => [ -78.22, 36.22 ], :pop => 2000, :state => "MD" ) 


            # check to see if 'city02' is there using _id - YES
                db[:zips].find(:_id => "100").to_a


        update_one
        ==========

            # find and then update_one
                db[:zips].find(:_id => "100").update_one(:$set => {:city => "name2"}) 


            # verify the update_one
                db[:zips].find(:_id => "100").to_a
 
        update_many
        ===========
            db[:zips].find(:state => 'MD').count
            db[:zips].find(:state => 'MD').update_many(:$set => {:state => 'XX'}) 
            db[:zips].find(:state => 'MD').count
            db[:zips].find(:state => 'XX').count

        delete_one
        ==========
            db[:zips].find(:city => 'name2').count
            db[:zips].find(:city => 'name2').delete_one()
            db[:zips].find(:city => 'name2').count

        delete_many
        ===========
            db[:zips].find(:state => 'MD' ).delete_many()

        upsert
        ======
            db[:zips].find(:city => "ODENVILLE1").count
            db[:zips].find(:city => "ODENVILLE2").count
            db[:zips].find(:city => "ODENVILLE1").update_one({:$set => {:city => "ODENVILLE2"}}, :upsert => true)
            db[:zips].find(:city => "ODENVILLE1").count
            db[:zips].find(:city => "ODENVILLE2").count

