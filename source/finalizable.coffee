VERSION: '0.0.1'

InstanceMembers:
  __finalizers__: []

  finalize: ->
    for fn in @__finalizers__
      (if typeof fn is 'string' then this[fn] else fn).call(this)
    this

ClassMembers:
  finalizer: ->
    this::__finalizers__ = this::__finalizers__.slice()
    for fn in arguments
      this::__finalizers__.push(fn)
    Object.freeze?(this::__finalizers__)
    this
