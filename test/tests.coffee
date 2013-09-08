(chai           = require 'chai').should()
{FooDB}         = require '../src/foo-db.coffee'
jsonData        = require './data.json'
server          = true
describe 'FooDB Tests', ->
  it 'should exist', =>
    (FooDB).should.be.a 'function'
  it 'should instantiate with a passed in data set', =>
    (@db = new FooDB jsonData).__collection.length().should.equal 7
  it 'should allow items to be added', (done)=>
    @db.on 'collectionChanged', (data)=>
      done() if data.added? and data.added.length == 2
    @db.create [{name:"newObject", value:"A New Object"},{name:"anotherObject", value:"Another New Object"}]
  it 'should allow items to update', =>
    ref = @db.read name:"anotherObject"
    ref[0].value = "A New Value"
    @db.update (objectId: ref[0].objectId), ref[0]
    (@db.read objectId:ref[0].objectId)[0].value.should.equal 'A New Value'
 