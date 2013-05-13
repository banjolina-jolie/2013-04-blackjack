  #todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    #@get('playerHand').on 'stand', => @evalDealerScore()
    @get('playerHand').on 'stand', => @flipAndEval()
    @set 'dealerHand', deck.dealDealer()

  evalDealerScore: ->
    dealerScore = @get("dealerHand").scores()

    if dealerScore[0] < 17
      @get('dealerHand').hit()
      @evalDealerScore()
    else @evalWinner()

  evalWinner: ->
    console.log("Evaluting winner")

  flipAndEval: ->
    @get('dealerHand').at(0).flip()
    @evalDealerScore()
