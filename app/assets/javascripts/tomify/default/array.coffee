Object.defineProperties Array.prototype, {
  compact: { get: -> x for x in @ when x },
  first: { get: -> @[0] },
  last: { get: -> @[@length - 1] }
}
