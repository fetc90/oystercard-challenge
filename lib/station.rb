
class Station

   attr_reader :name, :zone

   def initialize(name = "Bank", zone = 1)
       @zone = zone
       @name = name
   end

end
