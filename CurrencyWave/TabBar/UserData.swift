import Foundation

final class UserData {

    public enum SettingsKeys: String, CaseIterable {
        case currencies
        case pairs
        case currenciesNew
        case stringExchange
        case stringConverter
        case percent
    }

    static var percent: [String: Double] {
        get {
            if let saved = UserDefaults.standard.object(forKey: SettingsKeys.percent.rawValue) as? [String: Double] {
                return saved
            }
            return ["USD": 0.0, //USD
                    "EUR": 1.0, //EUR
                    "GBP" : 1.0, //GBP
                    "AUD": 0.0, //AUD
                    "BRL": 0.0, // BRL
                    "CAD": 0.0, //CAD
                    "CNY": 0.0, //CNY
                    "INR": 0.0, //INR
                    "ILS": 0.0, //ILS
                    "JPY": 0.0, //JPY
                    "RUB": 0.0, //RUB
                    "CHF": 0.0, //CHF
                    "NZD": 0.0, //NZD
                    "TRY": 0.0 //TRY
            ]
        }
    }

    static var stringConverter: [String: Double] {
        get {
            if let saved = UserDefaults.standard.object(forKey: SettingsKeys.stringConverter.rawValue) as? [String: Double] {
                return saved
            }
            return ["USD": 0.0, //USD
                    "EUR": 1.0, //EUR
                    "GBP" : 1.0, //GBP
                    "AUD": 0.0, //AUD
                    "BRL": 0.0, // BRL
                    "CAD": 0.0, //CAD
                    "CNY": 0.0, //CNY
                    "INR": 0.0, //INR
                    "ILS": 0.0, //ILS
                    "JPY": 0.0, //JPY
                    "RUB": 0.0, //RUB
                    "CHF": 0.0, //CHF
                    "NZD": 0.0, //NZD
                    "TRY": 0.0 //TRY
            ]
        }
    }

    static var stringExchange: [String] {
        get {
            if let saved = UserDefaults.standard.object(forKey: SettingsKeys.stringExchange.rawValue) as? [String] {
                return saved
            }
            return []
        }
    }

    static var currenciesNew: [String: Double] {
        get {
            if let saved = UserDefaults.standard.object(forKey: SettingsKeys.currenciesNew.rawValue) as? [String: Double] {
                return saved
            }
            return [
                "USD": 0.0, //USD
                "EUR": 1.0, //EUR
                "GBP" : 1.0, //GBP
                "AUD": 0.0, //AUD
                "BRL": 0.0, // BRL
                "CAD": 0.0, //CAD
                "CNY": 0.0, //CNY
                "INR": 0.0, //INR
                "ILS": 0.0, //ILS
                "JPY": 0.0, //JPY
                "RUB": 0.0, //RUB
                "CHF": 0.0, //CHF
                "NZD": 0.0, //NZD
                "TRY": 0.0 //TRY
            ]
        }
    }

    static var currencies: [String: Double] {
        get {
            if let saved = UserDefaults.standard.object(forKey: SettingsKeys.currencies.rawValue) as? [String: Double] {
                return saved
            }

            return [
                "EUR": 0.0,
                "USD": 1.0,
                "AUD": 0.0,
                "GBP": 0.0,
                "CAD": 0.0,
                "JPY": 0.0,
                "NZD": 0.0,
                "CHF": 0.0
            ]
        }
    }

    static var pairs: [String: Double] {
        get {
            if let saved = UserDefaults.standard.object(forKey: SettingsKeys.pairs.rawValue) as? [String: Double] {
                return saved
            }

            return [
                "EURUSD": 0.0,
                "EURCAD": 0.0,
                "AUDUSD": 0.0,
                "GBPUSD": 0.0,
                "GBPJPY": 0.0,
                "EURGBP": 0.0,
                "CADJPY": 0.0,
                "CADCHF": 0.0,
                "NZDJPY": 0.0,
                "USDJPY": 0.0,
                "EURCHF": 0.0,
                "EURJPY": 0.0,
                "USDCAD": 0.0,
                "USDCHF": 0.0,
                "GBPAUD": 0.0,
                "GBPCHF": 0.0,
                "NZDUSD": 0.0,
                "AUDCAD": 0.0,
                "AUDCHF": 0.0,
                "AUDJPY": 0.0
            ]
        }
    }
}
