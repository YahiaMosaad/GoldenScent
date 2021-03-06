//
//  Rows.swift
//  GoldenScent
//
//  Created by Yahia Mosaad on 03/03/2021.
//

import Foundation
// MARK: - Welcome
struct Rows: Codable {
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
    let font: String?
    let background: Background?
    let fontSize: String?

    enum CodingKeys: String, CodingKey {
        case type, src, slides, content
        case textAlign = "text-align"
        case fontColor = "font-color"
        case font, background
        case fontSize = "font-size"
    }
}

// MARK: - Background
struct Background: Codable {
    let color: String
}


// MARK: - Slide
struct Slide: Codable {
    let type: String
    let src: String
}
