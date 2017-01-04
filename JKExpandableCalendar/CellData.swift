//
//  CellData.swift
//  JKExpandableCalendar
//
//  Created by Jarosław Krajewski on 01/01/2017.
//  Copyright © 2017 jerronimo. All rights reserved.
//

import Foundation

open class CellData{
    public init(){
        
    }
    public func isMainCell() ->Bool{
        return self is PrimaryCellData
    }
}

open class PrimaryCellData:CellData{
    public var expanded = false
    public var subCellsData = [SecondaryCellData]()
}

open class SecondaryCellData:CellData{
    override public init() {
        super.init()
    }
}
