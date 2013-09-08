## foo-db
# (c)2013 Van Carney
#### A simple in-memory Object Store for protoyping
global = exports ? window
# include  Backbone and Underscore if we are in a Node App
if typeof exports != 'undefined'
  _       = require('underscore')._
  {ArrayCollection,Events} = require('js-arraycollection')
  # crypto  = require 'crypto'
(->
  # restrict our code to use less dangerous functionality
  'use strict'
  # define the 'sparse' global namespace
  if !global.FooDB
    FooDB = class global.FooDB
      __collection: new ArrayCollection []
      constructor:(data)->
        _.extend @, Events
        @create data if data?
        @__collection.on 'collectionChanged', (data)=>
          console.log 'trigering collectionChanged'
          @trigger 'collectionChanged', data
      create:(obj)->
        return null if !obj 
        #crypto.createHash('md5').update(Math.random().toString()).digest('hex').substring(0,16)
        @__collection.addAll _.map (if _.isArray obj then obj else [obj]), (v,k) => _.extend v, objectId : _.uniqueId() 
      read:(where)->
        if (where?) then _.where @__collection.__list, where else @__collection.__list
      update:(where,obj)->
        return null if !where
        _.map @read(where), (v,k) => _.extend v, obj
      destroy:(id)->
         @__collection.removeItemAt idx if (ref = @read objectId:id)? and (idx = @__collection.getItemIndex ref)?
).call @
