class window.App extends Backbone.Model

  initialize: ->
    @set 'chipCount', bank = @get('bank') or new Bank()
    @set 'deck', deck = @get('deck') or new Deck()
    if deck.length < 12 then deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @get('playerHand').on 'stand', => @flipAndEval()
    @get('playerHand').on 'bust', => @playerLoses()
    @get('playerHand').on '21', => @playerBlackjack()
    @get('playerHand').on 'blackjack', => @playerBlackjack()
    @set 'dealerHand', deck.dealDealer()
    @set 'numHands', @get('numHands') or 0
    @on 'addBet', =>
      console.log 'yolo'
      bank.add(@get('valueOfBet'))
      @set 'chipCount', @get('bank')
    @on 'subtractBet', =>
      console.log 'lose'
      bank.subtract(@get('valueOfBet'))
      @set 'chipCount', @get('bank')

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
    #@set 'chipCount', @get('chipCount') + @get('valueOfBet')
    @set 'numHands', @get('numHands') + 1
    @set 'chipCount', @get('chipCount') + @get('valueOfBet')
    @initialize()
    @trigger 'newgame'



