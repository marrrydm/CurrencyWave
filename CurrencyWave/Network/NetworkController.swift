import UIKit

final class NetworkController {
    static let shared = NetworkController()
    private var currenciesNew = UserData.currenciesNew
    private var tempCurrency = [String: Double]()

    private init() {
        getCurrencies()
    }

    private func getCurrencies() {
        let url = "https://api.currencyapi.com/v3/latest?apikey=cur_live_lVhrzFM9tM5f7TNt4c4eXHFm9cbxwhJEYE3OScDJ"

        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _  in
                guard let self = self else { return }
                if let data = data {
                    if let currencyResponse = try? JSONDecoder().decode(CurrencyValue.self, from: data) as CurrencyValue {
                        currencyResponse.data.forEach({ currency in
                            if currency.key == "EUR" || currency.key == "USD" || currency.key == "AUD" || currency.key == "GBP" || currency.key == "CAD" || currency.key == "JPY" || currency.key == "NZD" || currency.key == "CHF" ||
                                currency.key == "BRL" || currency.key == "CNY" ||
                                currency.key == "INR" || currency.key == "RUB" ||
                                currency.key == "TRY" {
                                let str = String(currency.key)
                                let val = 1 / Double(currency.value.value)
                                self.tempCurrency.updateValue(val, forKey: str)
                            }
                        })

                        UserDefaults.standard.set(self.tempCurrency, forKey: UserData.SettingsKeys.currenciesNew.rawValue)
                    }
                }
            }.resume()
        }
    }
}
