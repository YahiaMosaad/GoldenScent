//
//  Rows.swift
//  GoldenScent
//
//  Created by Yahia Mosaad on 03/03/2021.
//

import Foundation
// MARK: - Rows
struct Welcome: Codable {
    let rows: [Row]
}

// MARK: - Row
struct Row: Codable {
    let rowRowMarginLeft, rowMarginRight, rowMarginBottom: String?
    let columns: [Column]
    let rowMarginLeft, height, rowMArginRight, rowMarginBottoM: String?

    enum CodingKeys: String, CodingKey {
        case rowRowMarginLeft = "row-margin-left"
        case rowMarginRight = "row-margin-right"
        case rowMarginBottom = "row-margin-bottom"
        case columns
        case rowMarginLeft = "row-margin -left"
        case height
        case rowMArginRight = "row-m argin-right"
        case rowMarginBottoM = "row-margin-botto m"
    }
}

// MARK: - Column
struct Column: Codable {
    let type: String
    let src: String?
    let slides: [Slide]?
    let content, textAlign, fontColor: String?
    let columnFontSize: FontSize?
    let font: String?
    let background: Background?
    let fontSize: String?

    enum CodingKeys: String, CodingKey {
        case type, src, slides, content
        case textAlign = "text-align"
        case fontColor = "font-color"
        case columnFontSize = "font-size"
        case font, background
        case fontSize = "font- size"
    }
}

// MARK: - Background
struct Background: Codable {
    let color: String
}

enum FontSize: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(FontSize.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for FontSize"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Slide
struct Slide: Codable {
    let type: String
    let src: String
}
