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
      hand.hit()
      hand.hit()
      hand.hit()
      hand.hit()
      hand.hit()
      hand.hit()
      hand.hit()
      hand.hit()
      expect(hand.trigger).toHaveBeenCalled()
