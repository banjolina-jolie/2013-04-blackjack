class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'numHands', @get('numHands') or 0
    @set 'bank', new Bank()
    #if deck.length < 12 then deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @get('playerHand').on 'stand', => @flipAndEval()
    @get('playerHand').on 'bust', => @playerLoses()
    @get('playerHand').on 'blackjack', => @playerBlackjack()
    @set 'dealerHand', deck.dealDealer()
    @on 'addBet', =>
      @get('bank').add(@get('valueOfBet'))
    @on 'subtractBet', =>
      @get('bank').subtract(@get('valueOfBet'))

  evalDealerScore: ->
    dealerScore = @get("dealerHand").scores()

    if dealerScore[1] < 18 or dealerScore[0] < 17
      @get('dealerHand').hit()
      @evalDealerScore()
    else if dealerScore[0] > 21
      @dealerLoses()
    else @evalWinner()

  evalWinner: ->
    playerScore = @get('playerHand').scores()
    dealerScore = @get('dealerHand').scores()

    #set playerScore and dealerScore to their best score
    if playerScore[1] < 21
      playerScore = playerScore[1]
    else playerScore = playerScore[0]

    if dealerScore[1] < 21
      dealerScore = dealerScore[1]
    else dealerScore = dealerScore[0]

    if playerScore > dealerScore
      alert 'You have the better hand. You win!'
      @trigger 'addBet'

    else if playerScore == dealerScore
      alert 'Equal scores. It\'s a push.'

    else
      alert 'Dealer has better hand.  You lose'
      @trigger 'subtractBet'

    @set 'valueOfBet', 0
    @nextHand()

  flipAndEval: ->
    @get('dealerHand').at(0).flip()
    @evalDealerScore()

  playerLoses: ->
    alert 'You busted. Dealer wins'
    @trigger 'subtractBet'
    @nextHand()

  dealerLoses: ->
    alert 'Dealer busted. You win'
    @trigger 'addBet'
    @nextHand()

  playerBlackjack: ->
    alert 'blackJack. nice.'
    @trigger 'addBet'
    @nextHand()

  nextHand: ->
    # @off(['addBet', 'subtractBet'])
    @set 'numHands', @get('numHands') + 1
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'stand', => @flipAndEval()
    @get('playerHand').on 'bust', => @playerLoses()
    @get('playerHand').on 'blackjack', => @playerBlackjack()
    @trigger 'newgame'
