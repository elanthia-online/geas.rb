require "oga"
require "geas/parser/tag"
require "geas/parser/callbacks"
require "geas/parser/normalizer"

module Geas
  ##
  ## non-blocking thread-safe resistant 
  ## wrapper around Oga 
  ## most performant XML parser in Rubyland
  ##   
  class Parser
    ##
    ## blacklist used to filter edge nodes 
    ## from parser callbacks since they 
    ## have no context within Geas
    ##
    EDGE_NODES   = %i{a monster resource d 
                      output mode settingsinfo
                      endsetup switchquickbar
                      link cmdbutton dropdownbox
                      updowneditbox
                      nav updateverbs}
    ## attrs
    attr_reader :reader, :writer, :oga, :sax_callbacks
    ##
    ## create our parser
    ##        
    def initialize(world_callbacks)
      ## create a Thru IO objects
      @reader, @writer = IO.pipe
      ## create an instance for Callbacks
      @sax_callbacks = Callbacks.new(world_callbacks)
      ## put the parser in it's own error-safe
      ## Thread
      @oga = Thread.new do 
        begin
          Oga.sax_parse_html(@sax_callbacks, @reader)  
        rescue => exception
          System.log(exception, label: :parser_error)
        end
      end
    end
    ##
    ## normalize GS-nonsense
    ## write to the underlying IO
    ## 
    def puts(incoming)
      @writer.puts(
        Normalizer.apply(incoming))
    end
  end
end