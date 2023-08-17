import Foundation

final class UserData {

    public enum SettingsKeys: String, CaseIterable {
        case currencies
        case pairs
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
