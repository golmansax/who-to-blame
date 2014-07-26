module WhoToBlame
  class Snapshot
    attr_accessor :footprints, :date

    def initialize(date, footprints)
      self.date = date
      self.footprints = footprints
    end

    def as_json(*)
      {
        year: date.year,
        month: date.month,
        day: date.day,
        footprints: footprints,
      }
    end
  end
end
