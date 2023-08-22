import Foundation

struct CurrencyValue: Decodable {
    let meta: LastUpdate
    let data: [String: DateValue]
}

struct DateValue: Decodable {
    let code: String
    let value: Float
}

struct LastUpdate: Decodable {
    let last_updated_at: String
}
