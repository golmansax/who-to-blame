module WhoToBlame
  class PagesController < WhoToBlame::ApplicationController
    def index
      gon.authors = Author.all

      dates = Footprint.all.map(&:date).sort

      gon.dates = dates.map do |date|
        { year: date.year, month: date.month, day: date.day }
      end
    end
  end
end
