module WhoToBlame
  class PagesController < WhoToBlame::ApplicationController
    def index
      gon.authors = Author.all
    end
  end
end
