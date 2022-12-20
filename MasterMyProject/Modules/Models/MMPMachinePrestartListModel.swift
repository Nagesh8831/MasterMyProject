//
//  MMPMachinePrestartListModel.swift
//  MasterMyProject
//
//  Created by Mac on 12/12/22.
//

import Foundation
// MARK: - Welcome
struct MMPMachinePrestartListModel: Decodable {
    let statusCode: Int?
    let resultObject: MachineResultObject?
    let message: String?

//    enum CodingKeys: String, CodingKey {
//        case statusCode = "status_code"
//        case resultObject = "result_object"
//        case message
//    }
}

// MARK: - ResultObject
struct MachineResultObject: Decodable {
    let id, name: String?
    let fluidLevels: [FluidLevelList]?
    let inspectionList: [InspectionList]?

//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case fluidLevels = "Fluid Levels"
//        case inspectionList = "Inspection List"
//    }
}

// MARK: - FluidLevel
struct FluidLevelList: Decodable {
    let id, plantTypeID, preChkLstTypeID, title, createdAt, updatedAt: String?

//    enum CodingKeys: String, CodingKey {
//        case id
//        case plantTypeID = "plant_type_id"
//        case preChkLstTypeID = "pre_chk_lst_type_id"
//        case title
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
}
struct InspectionList: Decodable {
    let id, plantTypeID, preChkLstTypeID, title, createdAt, updatedAt: String?

//    enum CodingKeys: String, CodingKey {
//        case id
//        case plantTypeID = "plant_type_id"
//        case preChkLstTypeID = "pre_chk_lst_type_id"
//        case title
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
}
