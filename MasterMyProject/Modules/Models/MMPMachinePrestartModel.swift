//
//  MMPMachinePrestartModel.swift
//  MasterMyProject
//
//  Created by Mac on 12/12/22.
//

import Foundation
// MARK: - Welcome
struct MMPMachinePrestartModel: Codable {
    let proID, plantTypeID, datetime: String
    let fluidLevels, inspectionList: [FluidLevel]

    enum CodingKeys: String, CodingKey {
        case proID = "pro_id"
        case plantTypeID = "plant_type_id"
        case datetime
        case fluidLevels = "Fluid Levels"
        case inspectionList = "Inspection List"
    }
}

// MARK: - FluidLevel
struct FluidLevel: Codable {
    let id, plantTypeID, preChkLstTypeID, title, ans, createdAt, updatedAt: String

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

