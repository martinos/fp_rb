require "fp_rb/version"

require 'fp_rb/operator'
require 'fp_rb/maybe'
require 'fp_rb/result'

class Module
  # stolen from Rails mattr_accessor
  def def_fn(*syms, instance_reader: true, instance_accessor: true, default: nil)
    syms.each do |sym|
      raise NameError.new("invalid attribute name: #{sym}") unless (sym =~ /\A[_A-Za-z]\w*\z/)
      class_eval(<<-EOS, __FILE__, __LINE__ + 1)
        @@#{sym} = nil unless defined? @@#{sym}
        def self.#{sym}
          @@#{sym}
        end
      EOS

      if instance_reader && instance_accessor
        class_eval(<<-EOS, __FILE__, __LINE__ + 1)
          def #{sym}
            @@#{sym}
          end
        EOS
      end

      sym_default_value = (block_given? && default.nil?) ? yield : default
      class_variable_set("@@#{sym}", sym_default_value) unless sym_default_value.nil?
    end
  end
end

module FpRb
  def_fn :and_then

  @@and_then = ->f, a { a.and_then(f) }.curry
  @@map = ->f, a { a.map(f) }.curry
end
