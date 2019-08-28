TONALITY = [
  nil,
  "Cb",
  "Abm",
  "Gb",
  "Ebm",
  "Db",
  "Bbm",
  "Ab", # MAX
  "Fm",
  "Eb", # MAX
  "Cm",
  "Bb", # MAX
  "Gm", # MAX
  "F", # MAX
  "Dm", # MAX
  "C", # MAX
  "Am", # MAX
  "G", # MAX
  "Em", # MAX
  "D", # MAX
  "Bm", # MAX
  "A", # MAX
  "F#m", # MAX
  "E", # MAX
  "C#m",
  "B",
  "G#m",
  "F#",
  "D#m",
  "C#",
  "A#m",
]

def tonality_as_enum(tonality)
  TONALITY.index(tonality)
end

#circle of fifths
# keys = [
#   "Cb",
#   "Abm",
#   "Gb",
#   "Ebm",
#   "Db",
#   "Bbm",
#   "Ab",
#   "Fm",
#   "Eb",
#   "Cm",
#   "Bb",
#   "Gm",
#   "F",
#   "Dm",
#   "C",
#   "Am",
#   "G",
#   "Em",
#   "D",
#   "Bm",
#   "A",
#   "F#m",
#   "E",
#   "C#m",
#   "B",
#   "G#m",
#   "F#",
#   "D#m",
#   "C#",
#   "A#m",
# ]
