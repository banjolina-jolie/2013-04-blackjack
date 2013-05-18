class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = @get('deck') or new Deck()
    if deck.length < 12 then deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @get('playerHand').on 'stand', => @flipAndEval()
    @get('playerHand').on 'bust', => @playerLoses()
    @get('playerHand').on 'blackjack', => @playerBlackjack()
    @set 'dealerHand', deck.dealDealer()
    @set 'numHands', @get('numHands') or 0
    @set 'bank', bank = @get('bank') or new Bank()
    @on 'addBet', =>
      @get('bank').add(@get('valueOfBet'))
      @set 'bank', @get('bank')
    @on 'subtractBet', =>
      bank.subtract(@get('valueOfBet'))
      @set 'bank', @get('bank')

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

    else if playerScore == dealerScore
      alert 'Equal scores. It\'s a push.'

    else alert 'Dealer has better hand.  You lose'

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
    alert 'blackJack'
    @trigger 'addBet'
    @nextHand()

  nextHand: ->
    #@set 'bank', @get('bank') + @get('valueOfBet')
    @set 'numHands', @get('numHands') + 1
    #@set 'bank', @get('bank').value + @get('valueOfBet')
    @initialize()
    @trigger 'newgame'



