//
//  JKExpandableCalendar.swift
//  JKExpandableCalendar
//
//  Created by Jarosław Krajewski on 30/12/2016.
//  Copyright © 2016 jerronimo. All rights reserved.
//

import UIKit
public class JKExpandableCalendar: UIView {
    
    public var info:[CellData] = [CellData]()
    @IBOutlet var tableView: UITableView!
    public let MAIN_CELL_ID = "mainCell"
    public let SECONDARY_CELL_ID = "secondaryCell"
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadXib()
        tableView.dataSource = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        let test = PrimaryCellData()
        test.subCellsData.append(SecondaryCellData())
        test.subCellsData.append(SecondaryCellData())
        test.subCellsData.append(SecondaryCellData())
        test.subCellsData.append(SecondaryCellData())
        
        let test2 = PrimaryCellData()
        test2.subCellsData.append(SecondaryCellData())
        test2.subCellsData.append(SecondaryCellData())
        test2.subCellsData.append(SecondaryCellData())
        test2.subCellsData.append(SecondaryCellData())
        
        info.append(test)
        info.append(test2)
    }
    
    func loadXib(){
        let bundle = Bundle(identifier:"jerronimo.JKExpandableCalendar")
        let view = UINib(nibName: "JKExpandableCalendar", bundle: bundle).instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = self.bounds
        
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0))
        
        addSubview(view)
        tableView.register(UINib(nibName:"MainCell",bundle:bundle), forCellReuseIdentifier: MAIN_CELL_ID)
        tableView.register(UINib(nibName:"SecondaryCell",bundle:bundle), forCellReuseIdentifier: SECONDARY_CELL_ID)
    }
    
    public func reloadData(){
        tableView.reloadData()
    }
    
    public func registerMainCell(nib:UINib){
        tableView.register(nib, forCellReuseIdentifier: MAIN_CELL_ID)
    }
    
    public func registerSecondaryCell(nib:UINib){
        tableView.register(nib, forCellReuseIdentifier: SECONDARY_CELL_ID)
    }
}

extension JKExpandableCalendar:UITableViewDataSource{
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if info[indexPath.row].isMainCell(){
            return setupMainCell(for: indexPath)
        }else{
            return setupSecondaryCell(for: indexPath)
        }
    }
    
    private func setupMainCell(for indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: MAIN_CELL_ID, for: indexPath) as! MainCell
        cell.mainCellDelegate = self
        return cell
    }
    
    private func setupSecondaryCell(for indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: SECONDARY_CELL_ID, for: indexPath)
        return cell
    }
}

extension JKExpandableCalendar:MainCellDelegate{
    public func expandCell(_ cell:MainCell) {
        let index = tableView.indexPath(for: cell)!.row + 1
        if let cellInfo = info[index - 1] as? PrimaryCellData{
            if cellInfo.expanded{
                info.removeSubrange(index ..< index + cellInfo.subCellsData.count)
                cellInfo.expanded = false
                tableView.reloadData()
            }else{
                info.insert(contentsOf: cellInfo.subCellsData as [CellData], at: index)
                
                cellInfo.expanded = true
                tableView.reloadData()
            }
        }
    }
}
