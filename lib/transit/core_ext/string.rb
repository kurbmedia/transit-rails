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
    value = self.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n, '').to_s
    value.gsub!(/[']+/, '')
    value.gsub!(/\W+/, ' ')
    value.strip!
    value.downcase!
    value.gsub!(' ', '-')
    value
  end
end