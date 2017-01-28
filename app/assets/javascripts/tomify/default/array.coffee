Object.defineProperties Array.prototype, {
  first: { get: -> @[0] },
  last: { get: -> @[@length - 1] }
}
