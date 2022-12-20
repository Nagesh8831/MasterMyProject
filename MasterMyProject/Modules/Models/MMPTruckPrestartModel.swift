//
//  MMPTruckPrestartModel.swift
//  MasterMyProject
//
//  Created by Mac on 12/12/22.
//

import Foundation
// MARK: - Welcome
struct MMPTruckPrestartModel: Codable {
    let proID, plantTypeID, datetime: String
    let categoryA, categoryB, categoryC: [Category]

    enum CodingKeys: String, CodingKey {
        case proID = "pro_id"
        case plantTypeID = "plant_type_id"
        case datetime
        case categoryA = "Category A"
        case categoryB = "Category B"
        case categoryC = "Category C"
    }
}

// MARK: - Category
struct Category: Codable {
    let id, plantTypeID, preChkLstTypeID, title,createdAt, updatedAt, ans: String

    enum CodingKeys: String, CodingKey {
        case id
        case plantTypeID = "plant_type_id"
        case preChkLstTypeID = "pre_chk_lst_type_id"
        case title
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case ans
    }
}
