$ = (el) -> document.getElementById(el)

TemplateManager = ->
  return {
    tmj:
      $('thatsmyjam')

    retrieveTemplate: ->
      req = new XMLHttpRequest()
      req.onload = ->
        div = document.createElement('div')
        div.innerHTML = this.responseText
        window.mustacheTemplate = div
      templateUrl = @tmj.dataset.templateUrl
      req.open('GET', templateUrl, { async: false})
      req.send()
  }


class App
  constructor: (request) ->
    @request = request

  initRequest: =>
    uName = $('thatsmyjam').dataset.tmjUsername
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
        rendered = Mustache.render(window.mustacheTemplate.innerHTML, resp)
        $('thatsmyjam').innerHTML = rendered
        self.reformatDate(resp)
      if resp.person.hasCurrentJam
        $('noJam').innerHTML = ''
      else
        $('hasJam').innerHTML = ''


  responseAsJSON: (resp) =>
    JSON.parse(resp)

  reformatDate: (resp) ->
    dateEl = $('jam-creation-date')
    newDate = resp.jam?.creationDate.split(' ').slice(0, 4).join(' ')
    dateEl.innerHTML = newDate

templateManager = new TemplateManager()
templateManager.retrieveTemplate()

req = new XMLHttpRequest()
window.app = new App(req)
window.app.sendRequest().populateDom()
