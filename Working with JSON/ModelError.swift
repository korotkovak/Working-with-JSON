//
//  ModelError.swift
//  Working with JSON
//
//  Created by Kristina Korotkova on 01/03/23.
//

import Foundation

enum NetworkingError: String, Error {
    case jsonError = "Faild to decode JSON"
    case badRequest = "We could not process that action"
    case forbidden = "You exceeded the rate limit"
    case notFound = "The requested resource could not be found"
    case internalServerError = "We had a problem with our server. Please try again later"
    case serviceUnavailable = "We are temporarily offline for maintenance. Please try again later"
}

extension NetworkingError: LocalizedError {
    var errorDescription: String? { return NSLocalizedString(rawValue, comment: "")}
}
