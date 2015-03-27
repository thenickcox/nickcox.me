coreCompetencies =
  'Backbone.js': 0.5
  'CSS (incl CSS3, Sass)': 8
  'git': 4
  'HTML (incl HTML5, Haml)': 8
  'JavaScript & jQuery': 5
  'MySQL': 3
  'Object Oriented Design': 3
  'Rails': 3
  'Ruby': 3
  'TDD': 3
  'vim': 2.5

skills = []
years = []
for skill, year of coreCompetencies
  skills.push skill
  years.push coreCompetencies[skill]

data =
  labels: skills
  datasets: [
    fillColor: '#1e967b'
    data: years
    strokeColor: '#148c71'
    highlightFill: '#1e967b'
    highlightStroke: 'rgba(220,220,220,1)'
  ]

opts =
  scaleShowHorizontalLines: false
  scaleShowVerticalLines: false
  scaleFontFamily: "'Whitney SSm A', 'Whitney SSm B'",

ctx = document.getElementById('chart').getContext('2d')
myBarChart = new Chart(ctx).Bar(data, opts)
