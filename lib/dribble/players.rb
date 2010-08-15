module Dribble
  class Players
    attr_reader :players, :page, :pages, :per_page, :total, :api_endpoint, :player_name
    
    def initialize(players, attributes={})
      @players      = players
      @page         = attributes[:page]
      @pages        = attributes[:pages]
      @per_page     = attributes[:per_page]
      @total        = attributes[:total]
      @player_name  = attributes[:player_name]
      @api_endpoint = self.class.to_s.split('::').last.downcase.to_sym
    end
    
    
    ##
    # Previous Page
    #
    # @return [Object]
    # @api    public
    #
    def prev_page
      options       = {:page => self.page.to_i - 1}
      raise Dribble::NoMorePagesAvailable.new('You are already on the first page.') if options[:page] <= 0
      send_request(options)
    end
    
    
    ##
    # Next Page
    #
    # @return [Object]
    # @api    public
    #
    def next_page
      options       = {:page => self.page.to_i + 1}
      raise Dribble::NoMorePagesAvailable.new('You are already on the last page.') if options[:page] > self.pages.to_i
      send_request(options)
    end
    
    
    ##
    # Paginate
    #
    # @param  [Hash]    {:page => 3, :per_page => 15}
    # @return [Object]
    # @api    public
    #
    def paginate(options)
      raise Dribble::NoMorePagesAvailable.new('You are already on the last page.') if options[:page] > self.pages.to_i
      send_request(options)
    end
    
    
    private
      
      def send_request(options)
        if self.player_name
          Dribble::Player.send(@api_endpoint, self.player_name, options)
        else
          Dribble::Player.send(@api_endpoint, options)
        end
      end
    
  end
end


module Dribble
  class Followers < Players
  end
end

module Dribble
  class Draftees < Players
  end
end