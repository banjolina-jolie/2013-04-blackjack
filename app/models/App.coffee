  #todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    #@on 'stand', => @evaluateScore()
    @get('playerHand').on 'stand', => @evaluateScore()
    @set 'dealerHand', deck.dealDealer()

  evaluateScore: ->
    debugger
