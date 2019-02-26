class Module
  # Stripped down version of ActiveSupport's mattr_reader (don't want Rails dependencies)
  def fn_reader(*syms)
    syms.each do |sym|
      raise StandardError.new("invalid attribute name: #{sym}") unless /\A[_A-Za-z]\w*\z/.match
      class_eval(<<-EOS, __FILE__, __LINE__ + 1)
        @@#{sym} = nil unless defined? @@#{sym}

        def self.#{sym}
          @@#{sym}
        end
      EOS

      class_eval(<<-EOS, __FILE__, __LINE__ + 1)
          def #{sym}
            @@#{sym}
          end
        EOS

      sym_default_value = default
      class_variable_set("@@#{sym}", sym_default_value) unless sym_default_value.nil?
    end
  end
end
