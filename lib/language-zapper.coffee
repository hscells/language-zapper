LanguageZapperView = require './language-zapper-view'
{CompositeDisposable} = require 'atom'

module.exports = LanguageZapper =
  languageZapperView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @languageZapperView = new LanguageZapperView(state.languageZapperViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @languageZapperView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'language-zapper:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @languageZapperView.destroy()

  serialize: ->
    languageZapperViewState: @languageZapperView.serialize()

  toggle: ->
    console.log 'LanguageZapper was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
