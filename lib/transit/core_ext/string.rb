class String

  ##
  # Extends string to convert boolean values to 
  # a True/False class
  # 
  def to_bool
    return true if self == true || self =~ (/^(true|t|yes|y|1)$/i)
    return false if self == false || self.blank? || self =~ (/^(false|f|no|n|0)$/i)
    raise ::ArgumentError.new("invalid value for Boolean: \"#{self}\"")
  end
  
  
  ##
  # Extends string to create url friendly formatted values.
  # Removes all non url-friendly characters and replaces spaces and underscores with hyphens.
  # Original implemention by Ludo van den Boom
  # @see https://github.com/ludo/to_slug
  # 
  def to_slug
    # Perform transliteration to replace non-ascii characters with an ascii
    # character
    value = mb_chars.unicode_normalize.gsub(/[^\x00-\x7F]/n, '').to_s

    # Remove single quotes from input
    value.gsub!(/'+/, '')

    # Replace any non-word character (\W) with a space
    value.gsub!(/\W+/, ' ')

    # Remove any whitespace before and after the string
    value.strip!

    # All characters should be downcased
    value.downcase!

    # Replace spaces with dashes
    value.tr!(' ', '-')

    # Return the resulting slug
    value
  end
end