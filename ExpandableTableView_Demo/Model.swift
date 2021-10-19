//
//  Model.swift
//  ExpandableTableView_Demo
//
//  Created by 준수김 on 2021/10/19.
//

import Foundation

struct cellData {
    var opened = Bool() //cell의 확장여부
    var image = String()
    var title = String() //카테고리 제목
    var sectionData = [String]() //카테고리 내용
}
