describe 'hand', ->
  deck = null
  hand = null


  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()
    spyOn(hand, 'trigger')

  describe 'scores', ->
    xit "should increment scores after a hit", ->
      oldScore = hand.scores()[0]
      hand.hit()
      expect(hand.scores()[0]).toBeGreaterThan(oldScore)


    xit "should bust after score is greater than 21", ->
      while hand.scores()[0] < 22
        hand.hit()

      expect(hand.trigger.mostRecentCall.args[0]).toEqual('bust')


    it "should trigger blackjack if score is toEqual 21", ->
      card1 = new Card
        rank: 1
        suit: Math.floor(1)

      card2 = new Card
        rank: 0
        suit: Math.floor(1)

      hand = new Hand [card1, card2]
      spyOn(hand, 'trigger')
      hand.scores();
      console.log(hand.trigger.calls.length)
      expect(hand.trigger.mostRecentCall.args[0]).toEqual('blackjack')
