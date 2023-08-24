import UIKit

final class NetworkController {
    static let shared = NetworkController()
    private var currenciesNew = UserData.currenciesNew
    private var percent = UserData.percent
    private var tempCurrency = [String: Double]()
    private var tempPercent = [String: Double]()

    private init() {
        getCurrencies()
    }

    private func getCurrencies() {
//        "https://api.currencyapi.com/v3/latest?apikey=cur_live_fc7451e6b7fc7be5f47c96b13ace2378"
        let url = "http://api.currencyapi.com/v3/latest?apikey=cur_live_zJk5p17yBerLLZy3sKEG7jidEtvG6nFc4QjTEbjQ"

        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _  in
                guard let self = self else { return }
                if let data = data {
                    if let currencyResponse = try? JSONDecoder().decode(CurrencyValue.self, from: data) as CurrencyValue {
                        currencyResponse.data.forEach({ currency in
                            if currency.key == "EUR" || currency.key == "USD" || currency.key == "AUD" || currency.key == "GBP" || currency.key == "CAD" || currency.key == "JPY" || currency.key == "NZD" || currency.key == "CHF" ||
                                currency.key == "BRL" || currency.key == "CNY" ||
                                currency.key == "INR" || currency.key == "RUB" ||
                                currency.key == "TRY" || currency.key == "IDR" ||
                                currency.key == "ILS" || currency.key == "MXN" {
                                let str = String(currency.key)
                                let val = 1 / Double(currency.value.value)
                                self.tempCurrency.updateValue(val, forKey: str)
                                self.tempPercent.updateValue(val, forKey: str)
                            }
                        })
                        UserDefaults.standard.set(self.tempCurrency, forKey: UserData.SettingsKeys.currenciesNew.rawValue)
                        UserDefaults.standard.set(self.tempPercent, forKey: UserData.SettingsKeys.percent.rawValue)
                    }
                }
            }.resume()
        }
    }
}
