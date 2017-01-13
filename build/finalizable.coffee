###!
# finalizable 1.0.1 | https://github.com/yivo/finalizable | MIT License
###

((factory) ->

  __root__ = 
    # The root object for Browser or Web Worker
    if typeof self is 'object' and self isnt null and self.self is self
      self

    # The root object for Server-side JavaScript Runtime
    else if typeof global is 'object' and global isnt null and global.global is global
      global

    else
      Function('return this')()

  # Asynchronous Module Definition (AMD)
  if typeof define is 'function' and typeof define.amd is 'object' and define.amd isnt null
    define ['coffee-concerns'], () ->
      __root__.Finalizable = factory(__root__, Object)

  # Server-side JavaScript Runtime compatible with CommonJS Module Spec
  else if typeof module is 'object' and module isnt null and typeof module.exports is 'object' and module.exports isnt null
    module.exports = factory(__root__, Object, require('coffee-concerns'))

  # Browser, Web Worker and the rest
  else
    __root__.Finalizable = factory(__root__, Object)

  # No return value
  return

)((__root__, Object) ->
  VERSION: '1.0.1'
  
  InstanceMembers:
    finalized:      false
    finalizing:     false
    __finalizers__: []
  
    finalize: ->
      if not @finalized and not @finalizing
        @finalizing = true
        for fn in @__finalizers__
          (if typeof fn is 'string' then this[fn] else fn).call(this)
        @finalizing = false
        @finalized  = true
      this
  
  ClassMembers:
    finalizer: ->
      this::__finalizers__ = this::__finalizers__.slice()
      for fn in arguments
        this::__finalizers__.push(fn)
      Object.freeze?(this::__finalizers__)
      this
)