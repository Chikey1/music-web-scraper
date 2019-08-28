module ChordQualities
  COMMON_NAMES = {
    POWER_CHORD => "power chord",
  }.merge(SEVEN_CHORDS).merge(TRIADS)

  ALTERNATIVE_NAMES = {
    "M" => "maj",
  }

  SEVEN_CHORDS = {
    POWER_CHORD => "power chord",
    MAJOR_SEVENTH => "major seventh",
    MINOR_SEVENTH => "m7",
    DIMINISHED_SEVENTH => "dim",
    DOMINANT_SEVENTH => "7",
  }

  TRIADS = {
    MAJOR => "major",
    MINOR => "minor",
  }

  POWER_CHORD = "5"

  MAJOR = "maj"
  MINOR = "m"

  MAJOR_SEVENTH = "maj7"
  MINOR_SEVENTH = "m7"
  DIMINISHED_SEVENTH = "dim"
  DOMINANT_SEVENTH = "7"
  HALF_DIMINISHED = nil
end