  #todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @get('playerHand').on 'stand', => @flipAndEval()
    @get('playerHand').on 'bust', => @playerLoses()

    @set 'dealerHand', deck.dealDealer()


  evalDealerScore: ->
    dealerScore = @get("dealerHand").scores()

    if dealerScore[0] < 17
      @get('dealerHand').hit()
      @evalDealerScore()
    else if dealerScore > 21
      @dealerLoses()
    else @evalWinner()

  evalWinner: ->
    playerScore = @get('playerHand').scores()
    dealerScore = @get('dealerHand').scores()

    if playerScore[0] > dealerScore[0]
      alert 'You have the better hand. You win!'

    else alert 'Dealer has better hand.  You lose'

    #@initialize()



  flipAndEval: ->
    @get('dealerHand').at(0).flip()
    @evalDealerScore()

  playerLoses: ->
    alert 'You busted. Dealer wins'
    #new AppView(model: new App()).$el.appendTo 'body'


  dealerLoses: ->
    alert 'Dealer busted. You win'
    #new AppView(model: new App()).$el.appendTo 'body'