module Rater
  class TrueSkill
    DefaultValue     = 0
    DefaultMean      = 25
    DefaultDeviation = 25.0 / 3.0

    def hello_world
      team1 = [
        Saulabs::TrueSkill::Rating.new(DefaultMean, DefaultDeviation),
        Saulabs::TrueSkill::Rating.new(DefaultMean, DefaultDeviation)
      ]
      team2 = [
        Saulabs::TrueSkill::Rating.new(DefaultMean, DefaultDeviation),
        Saulabs::TrueSkill::Rating.new(DefaultMean, DefaultDeviation)
      ]
      graph = Saulabs::TrueSkill::FactorGraph.new(team1 => 1, team2 => 2)
      graph.update_skills
      graph
    end
  end
end
