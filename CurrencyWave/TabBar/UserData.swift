import UIKit

final class UserData {

    public enum SettingsKeys: String, CaseIterable {
        case currencies
        case pairs
        case currenciesNew
        case stringExchange
        case stringConverter
        case percent
        case country
    }

    static var country: String {
        get {
            if let saved = UserDefaults.standard.object(forKey: SettingsKeys.country.rawValue) as? String {
                return saved
            }
            return "usa"
        }
    }

    static var percent: [String: Double] {
        get {
            if let saved = UserDefaults.standard.object(forKey: SettingsKeys.percent.rawValue) as? [String: Double] {
                return saved
            }
            return ["USD": 1.0, //USD
                    "EUR": 1.0, //EUR
                    "GBP" : 1.0, //GBP
                    "AUD": 1.0, //AUD
                    "BRL": 1.0, // BRL
                    "CAD": 1.0, //CAD
                    "CNY": 1.0, //CNY
                    "INR": 1.0, //INR
                    "ILS": 1.0, //ILS
                    "JPY": 1.0, //JPY
                    "RUB": 1.0, //RUB
                    "CHF": 1.0, //CHF
                    "NZD": 1.0, //NZD
                    "TRY": 1.0, //TRY
                    "THB": 1.0 
            ]
        }
    }

    static var stringConverter: [String: Double] {
        get {
            if let saved = UserDefaults.standard.object(forKey: SettingsKeys.stringConverter.rawValue) as? [String: Double] {
                return saved
            }
            return ["USD": 1.0, //USD
                    "EUR": 1.0, //EUR
                    "AUD": 1.0, //AUD
                    "CAD": 1.0
            ]
        }
    }

    static var stringExchange: [String] {
        get {
            if let saved = UserDefaults.standard.object(forKey: SettingsKeys.stringExchange.rawValue) as? [String] {
                return saved
            }
            return [
                "EUR",
                "GBP",
                "AUD",
                "CAD"
            ]
        }
    }

    static var currenciesNew: [String: Double] {
        get {
            if let saved = UserDefaults.standard.object(forKey: SettingsKeys.currenciesNew.rawValue) as? [String: Double] {
                return saved
            }
            return [
                "USD": 1.0, //USD
                "EUR": 1.0, //EUR
                "GBP": 1.0, //GBP
                "AUD": 1.0, //AUD
                "BRL": 1.0, // BRL
                "CAD": 1.0, //CAD
                "CNY": 1.0, //CNY
                "INR": 1.0, //INR
                "ILS": 1.0, //ILS
                "JPY": 1.0, //JPY
                "RUB": 1.0, //RUB
                "CHF": 1.0, //CHF
                "NZD": 1.0, //NZD
                "TRY": 1.0, //TRY
                "THB": 1.0
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
