module Transit
  class SnippetsController < TransitController
    before_filter :perform_authentication_method
    layout false
  end
end