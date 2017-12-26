class Monster < Sequel::Model
    one_to_one :monster_type
    def initialize(params = {})
        super(params)
        @details = MonsterType.find(id: @monster_id)
    end
end
