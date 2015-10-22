class BetaPackGenerator
  def initialize
    commons = []
    uncommons = []
    rares = []
    File.read("abu.checklist").split("\n").each do |line|
      card, artist, rarity = line.split("\t")
      case rarity[0]
        when "C"
          commons << card
        when "U"
          uncommons << card
        when "R"
          rares << card
        else
          raise ArgumentError "wtfmonkies"
      end
    end

# Islands are rare!
    4.times { rares << "Island"}

# Basics are uncommon!
    6.times { uncommons << "Plains"}
    2.times { uncommons << "Island"}
    6.times { uncommons << "Swamp"}
    6.times { uncommons << "Mountain"}
    6.times { uncommons << "Forest"}

# Basics are common!
    9.times {
      commons << "Island"
      commons << "Swamp"
      commons << "Mountain"
      commons << "Forest"
    }
    8.times { commons << "Plains"}
    commons << "Island"
    commons << "Mountain"

    @commons = commons
    @uncommons = uncommons
    @rares = rares
  end


  def pack
    pack = []
    pack << @rares.sample
    3.times { pack << @uncommons.sample }
    11.times { pack << @commons.sample }
    return pack
  end


  def packs(number)
    output = []
    number.times do
      output += pack
    end
    return output
  end


  def remove_basics(pool)
    pool - %w(Plains Island Swamp Mountain Forest)
  end

end
