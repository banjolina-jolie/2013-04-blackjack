describe 'hand', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()
    spyOn(hand, 'trigger')

  describe 'scores', ->
    it "should increment scores after a hit", ->
      oldScore = hand.scores()[0]
      hand.hit()
      expect(hand.scores()[0]).toBeGreaterThan(oldScore)


    it "should bust after score is greater than 21", ->
      while hand.scores()[0] < 21
        hand.hit()
        
      expect(hand.trigger.mostRecentCall.args[0]).toEqual('bust')
