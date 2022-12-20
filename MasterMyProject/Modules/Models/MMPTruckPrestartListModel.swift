//
//  MMPTruckPrestartListModel.swift
//  MasterMyProject
//
//  Created by Mac on 12/12/22.
//

import Foundation
struct MMPTruckPrestartListModel: Codable {
    let statusCode: Int
    let resultObject: TruckResultObject
    let message: String

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case resultObject = "result_object"
        case message
    }
}

// MARK: - ResultObject
struct TruckResultObject: Codable {
    let id, name: String
    let categoryA, categoryB, categoryC: [CategoryList]

    enum CodingKeys: String, CodingKey {
        case id, name
        case categoryA = "Category A"
        case categoryB = "Category B"
        case categoryC = "Category C"
    }
}

// MARK: - Category
struct CategoryList: Codable {
    let id, plantTypeID, preChkLstTypeID, title, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case plantTypeID = "plant_type_id"
        case preChkLstTypeID = "pre_chk_lst_type_id"
        case title
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

