
def attribute (arg,&block)
  svar = arg if arg.instance_of?(String)             # svar is given variable name in String representation
  svar,val = arg.first if arg.instance_of?(Hash)     # val  is given devault value to variable
  ivar = "@#{svar}"                                  # ivar is given variable name in instance_variable representation
  class_eval do

    attr_writer svar.to_sym                          # it provides setter to variable name            

    define_method "#{svar}?".to_sym do               # it provides query  to variable name
      !instance_variable_get(ivar).nil?              # false will return if variable was not setted
    end

    define_method svar.to_sym do                     # it provides getter to variable name
      unless instance_variable_defined?(ivar)        # if variable is not defined 
        val = instance_eval &block if block_given?   # if block given evaluate given block in instance scope and return evaluation to val
        instance_variable_set(ivar,val) if val       # if val isn't nil set default value to instance variable
      end
      instance_variable_get(ivar)                    # return value of instance variable 
    end

  end
end