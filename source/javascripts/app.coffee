class App
  constructor: (request) ->
    @request = request

  initRequest: =>
    uName = document.getElementById('thatsmyjam').dataset.tmjUsername
    @request.open('GET', "https://api.thisismyjam.com/1/#{uName}.json", { async: false })

  sendRequest: =>
    @initRequest()
    @request.send()
    this

  populateDom: =>
    self = @
    @request.addEventListener 'loadend', ->
      if @status is 200 && @response
        resp = self.responseAsJSON(@response)
        templ = document.getElementById('tmj-template').innerHTML
        rendered = Mustache.render(templ, resp)
        document.getElementById('thatsmyjam').innerHTML = rendered
        self.reformatDate(resp)

  responseAsJSON: (resp) =>
    JSON.parse(resp)

  domHook:
    document.getElementById('thatsmyjam')

  reformatDate: (resp) ->
    dateEl = document.getElementById('jam-creation-date')
    newDate = resp.jam.creationDate.split(' ').slice(0, 4).join(' ')
    dateEl.innerHTML = newDate


req = new XMLHttpRequest()
window.app = new App(req)
window.app.sendRequest().populateDom()
