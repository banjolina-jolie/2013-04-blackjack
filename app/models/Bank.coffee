class window.Bank extends Backbone.Model

  initialize: ->
    @value = 100
    @.on 'addBet', => @add()
    @.on 'subtractBet', => @subtract()

  add: (amount) =>
    @value = @value + Number(amount)

  subtract: (amount) =>
    @value = @value - Number(amount)
