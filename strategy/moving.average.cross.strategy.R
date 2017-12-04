library(R6)

MovingAverageCrossStrategy <- R6Class("MovingAverageCrossStrategy",
  inherit = StrategyBase,
  public = list(
    short.window = 0,
    long.window = 0,
    bars = 0,
    invested = FALSE,
    prices = NULL,
    #------------------- constructor -----------------------#
    initialize = function(symbols) {
      super$initialize(symbols)

      self$short.window <- 50
      self$long.window <- 200

      self$Reset()
    },
    #-------------- function Reset -----------------#
    Reset = function() {
      self$bars <- 0
      self$invested <- FALSE
      self$prices <- c()
    },
    #-------------- function OnStop -----------------#
    OnBar = function(bar.event) {
      if (self$symbols[1] == bar.event$full.symbol) {
        self$prices <- c(self$prices, bar.event$adj.close.price)
        self$bars = self$bars + 1

        if (self$bars >= self$long.window)
        {
          short.sma <- mean( self$prices[(length(self$prices)-self$short.window+1):length(self$prices)] )
          long.sma <- mean( self$prices[(length(self$prices)-self$long.window+1):length(self$prices)] )

          if ((short.sma > long.sma) && (!self$invested)) {
            print(paste( 'long', bar.event$BarEndTime(), 'short.sma', short.sma, 'long.sma', long.sma  ))

            o <- OrderEvent$new()
            o$full.symbol <- self$symbols[1]
            o$order.type <- 'MARKET'
            o$size <- 100
            self$PlaceOrder(o)
            self$invested <- TRUE
          }
          else if ((short.sma < long.sma) && self$invested) {
            print(paste( 'short', bar.event$BarEndTime(), 'short.sma', short.sma, 'long.sma', long.sma  ))

            o <- OrderEvent$new()
            o$full.symbol <- self$symbols[1]
            o$order.type <- 'MARKET'
            o$size <- -100
            self$PlaceOrder(o)
            self$invested <- FALSE
          }
        }
      }
    }
  )
)
