module Rater
  class TrueSkill
    DEFAULT_MEAN      = 25
    DEFAULT_DEVIATION = 25.0 / 3.0

    def generate
      team1 = [
        Saulabs::TrueSkill::Rating.new(DEFAULT_MEAN, DEFAULT_DEVIATION),
        Saulabs::TrueSkill::Rating.new(DEFAULT_MEAN, DEFAULT_DEVIATION)
      ]
      team2 = [
        Saulabs::TrueSkill::Rating.new(DEFAULT_MEAN, DEFAULT_DEVIATION),
        Saulabs::TrueSkill::Rating.new(DEFAULT_MEAN, DEFAULT_DEVIATION)
      ]
      graph = Saulabs::TrueSkill::FactorGraph.new(team1 => 1, team2 => 2)
      graph.update_skills
      graph
    end
  end
end
