exp = (name)-> Transit.Validators.expressions[name]

Validators = 
  
  ##
  # RegExp strings
  #
  expressions:
    type: /\[type=([a-z]+)\]/
    number: /^-?[0-9]*(\.[0-9]+)?$/
    email: /^([a-z0-9_\.\-\+]+)@([\da-z\.\-]+)\.([a-z\.]{2,6})$/i
    url: /^(https?:\/\/)?[\da-z\.\-]+\.[a-z\.]{2,6}[#&+_\?\/\w \.\-=]*$/i
    
  # Validate a string as an email address
  email:( val )-> !val || exp(email).test(val)
  
  
  # Validate a string as a number
  number:( val )-> !val || exp(number).test(val)
  
  
  # Validate a value exists
  presence:( val )-> !!val
  
  
  # Validate a string as a url.
  url:( val )-> !val || exp(url).test(val)
  
  
@Transit.Validators = Validators
   
  