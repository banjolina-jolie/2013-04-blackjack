class window.HandView extends Backbone.View

  className: 'hand'

  #todo: switch to mustache
  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    myScores =  @collection.scores()
    if myScores[1] and @collection.at(0).get 'revealed'
      @$('.score').text myScores[1] + " or " + myScores[0]
    else
      @$('.score').text myScores[0]
