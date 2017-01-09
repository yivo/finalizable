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
