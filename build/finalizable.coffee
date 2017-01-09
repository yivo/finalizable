((factory) ->

  # Browser and WebWorker
  root = if typeof self is 'object' and self isnt null and self.self is self
    self

  # Server
  else if typeof global is 'object' and global isnt null and global.global is global
    global

  # AMD
  if typeof define is 'function' and typeof define.amd is 'object' and define.amd isnt null
    root.Finalizable = factory(root, Object)
    define -> root.Finalizable

  # CommonJS
  else if typeof module is 'object' and module isnt null and
          typeof module.exports is 'object' and module.exports isnt null
    module.exports = factory(root, Object)

  # Browser and the rest
  else
    root.Finalizable = factory(root, Object)

  # No return value
  return

)((__root__, Object) ->
  VERSION: '1.0.0'
  
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