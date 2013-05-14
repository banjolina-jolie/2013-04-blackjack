describe 'hand', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  describe 'scores', ->
    it "should increment scores after a hit", ->
      oldScore = hand.scores()[0]
      hand.hit()
      expect(hand.scores()[0]).toBeGreaterThan(oldScore)
