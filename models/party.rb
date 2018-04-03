class Party < Sequel::Model
    one_to_many :characters
    one_to_many :encounters

    def levelUp
        self.level = self.level + 1
        self.save_changes
    end

    def levelDown
        self.level = self.level > 1 ? self.level - 1 : 1
        self.save_changes
    end
end
