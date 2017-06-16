require "fp_rb/version"

require 'fp_rb/operator'
require 'fp_rb/maybe'
require 'fp_rb/result'
require 'active_support/core_ext/module/attribute_accessors'

module FpRb
  mattr_reader :and_then

  @@and_then = -> f, a { a.and_then(f) }.curry
  @@map = -> f, a { a.map(f) }.curry
end
