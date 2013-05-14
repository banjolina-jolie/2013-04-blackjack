  #todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = @get('deck') or new Deck()
    if deck.length < 12 then deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @get('playerHand').on 'stand', => @flipAndEval()
    @get('playerHand').on 'bust', => @playerLoses()
    @get('playerHand').on '21', => @playerBlackjack()

    @get('playerHand').on 'blackjack', => @playerBlackjack()
    @set 'dealerHand', deck.dealDealer()
    @set 'numHands', @get('numHands') or 0

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

    else if playerScore[0] == dealerScore[0]
      alert 'Equal scores. It\'s a push.'

    else alert 'Dealer has better hand.  You lose'

    @nextHand()

  flipAndEval: ->
    @get('dealerHand').at(0).flip()
    @evalDealerScore()

  playerLoses: ->
    alert 'You busted. Dealer wins'
    @nextHand()

  dealerLoses: ->
    alert 'Dealer busted. You win'
    @nextHand()

  playerBlackjack: ->
    alert 'blackJack'
    @nextHand()

  nextHand: ->
    @set 'numHands', (@get('numHands') + 1)
    @initialize()
    @trigger('newgame')
