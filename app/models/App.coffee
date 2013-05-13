  #todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @get('playerHand').on 'stand', => @evalDealerScore()
    @set 'dealerHand', deck.dealDealer()

  evalDealerScore: ->
    dealerScore = @get("dealerHand").scores()

    if dealerScore < 17
      @get('dealerHand').hit()
      @evalDealerScore()
    else @evalWinner()

  evalWinner: ->
    console.log("Evaluting winner")