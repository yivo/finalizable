(function() {
  (function(factory) {
    var root;
    root = typeof self === 'object' && self !== null && self.self === self ? self : typeof global === 'object' && global !== null && global.global === global ? global : void 0;
    if (typeof define === 'function' && typeof define.amd === 'object' && define.amd !== null) {
      root.finalizable = factory(root, Object);
      define(function() {
        return root.finalizable;
      });
    } else if (typeof module === 'object' && module !== null && typeof module.exports === 'object' && module.exports !== null) {
      module.exports = factory(root, Object);
    } else {
      root.finalizable = factory(root, Object);
    }
  })(function(__root__, Object) {
    return {
      VERSION: '0.0.1',
      InstanceMembers: {
        __finalizers__: [],
        finalize: function() {
          var fn, i, len, ref;
          ref = this.__finalizers__;
          for (i = 0, len = ref.length; i < len; i++) {
            fn = ref[i];
            (typeof fn === 'string' ? this[fn] : fn).call(this);
          }
          return this;
        }
      },
      ClassMembers: {
        finalizer: function() {
          var fn, i, len;
          this.prototype.__finalizers__ = this.prototype.__finalizers__.slice();
          for (i = 0, len = arguments.length; i < len; i++) {
            fn = arguments[i];
            this.prototype.__finalizers__.push(fn);
          }
          if (typeof Object.freeze === "function") {
            Object.freeze(this.prototype.__finalizers__);
          }
          return this;
        }
      }
    };
  });

}).call(this);
