//
//  Errors.swift
//  goliath
//
//  Created by Christophe Beaulieu on 2025-08-20.
//

enum AppError: Error {
//    // MARK: - Networking
//    case networkUnavailable
//    case requestFailed(underlying: Error?)
//    case invalidResponse
//    case timeout

    // MARK: - Database / Persistence
    case keyNotFound(key: String)
    case dataNotFound(entity: String)
    case saveFailed(underlying: Error?)
    case migrationFailed(reason: String)

    // MARK: - Decoding / Encoding
    case decodingFailed(underlying: Error?)
    case encodingFailed(underlying: Error?)
    case invalidData(reason: String)

    // MARK: - Validation
    case invalidInput(reason: String)
    case missingRequiredField(field: String)

    // MARK: - Generic / Unknown
    case unauthorized
    case unknown(reason: String)
}

