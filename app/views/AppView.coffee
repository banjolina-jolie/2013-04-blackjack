class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <span class="counter-container"></span>
    <div class="player-hand-container"></div><span class="chip-count"></span>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()

  initialize: ->
    @render()
    @model.on('newgame', =>
      @render() )

  render: ->
    @$el.children().detach()
    @model.set 'valueOfBet', Number(prompt "How much you wanna bet?", "0")
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.counter-container').html("Number of Games Played: " + @model.get 'numHands')
    @$('.chip-count').html("Chip Count: " + @model.get('bank').value)
