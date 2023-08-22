import Foundation

final class TradingView {

    private let width: Double
    private let height: Double
    private var symbol = "EURUSD"

    private let chartPrototype = """
    <html>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <body bgcolor="#F6F9FC">
    <!-- TradingView Widget BEGIN -->
    <div class="tradingview-widget-container">
      <div id="tradingview_bdc2c"></div>
      <div class="tradingview-widget-copyright"><a href="https://www.tradingview.com/symbols/EURUSD/?exchange=BITSTAMP" rel="noopener" target="_blank"><span class="blue-text">%symbol% Chart</span></a> by TradingView</div>
      <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
      <script type="text/javascript">
      new TradingView.widget(
      {
      "width": %width%,
      "height": %height%,
      "symbol": "FX:%symbol%",
      "interval": "1",
      "timezone": "Etc/UTC",
      "theme": "light",
      "style": "1",
      "locale": "en",
      "toolbar_bg": "#1D1E22",
      "enable_publishing": false,
      "hide_top_toolbar": true,
      "save_image": false,
      "container_id": "tradingview_bdc2c"
    }
      );
      </script>
    </div>
    <!-- TradingView Widget END -->
    </body>
    </html>
    """

    private var chartContent = ""

    init(width: Double, height: Double, symbol: String) {
        self.width = width
        self.height = height
        self.symbol = symbol

        setupChart()
    }

    private func setupChart() {
        chartContent = chartPrototype.replacingOccurrences(of: "%width%", with: "\(width)")
        chartContent = chartContent.replacingOccurrences(of: "%height%", with: "\(height)")
        chartContent = chartContent.replacingOccurrences(of: "%symbol%", with: "\(symbol)")
    }

    public func getHTMLContent() -> String {
        return chartContent
    }
}

