WelcomeScreenView = require './welcome-screen-view'
{CompositeDisposable} = require 'atom'

module.exports = WelcomeScreen =
  welcomeScreenView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @welcomeScreenView = new WelcomeScreenView(state.welcomeScreenViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @welcomeScreenView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'welcome-screen:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @welcomeScreenView.destroy()

  serialize: ->
    welcomeScreenViewState: @welcomeScreenView.serialize()

  toggle: ->
    console.log 'WelcomeScreen was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
