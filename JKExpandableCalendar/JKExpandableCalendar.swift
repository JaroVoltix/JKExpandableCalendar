//
//  JKExpandableCalendar.swift
//  JKExpandableCalendar
//
//  Created by Jarosław Krajewski on 30/12/2016.
//  Copyright © 2016 jerronimo. All rights reserved.
//

import UIKit

public class cellInfo{
    var type = 0
    var expanded:Bool = false
    var subcellInfo:[cellInfo] = [cellInfo]()
    
    init(_ type:Int) {
        self.type = type
    }
}

public class JKExpandableCalendar: UIView {

    var info:[cellInfo] = [cellInfo]()
    @IBOutlet var tableView: UITableView!
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadXib()
        tableView.dataSource = self
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        let test = cellInfo(0)
        test.subcellInfo.append(cellInfo(1))
        test.subcellInfo.append(cellInfo(1))
        test.subcellInfo.append(cellInfo(1))
        test.subcellInfo.append(cellInfo(1))
        
        let test2 = cellInfo(0)
        test2.subcellInfo.append(cellInfo(1))
        test2.subcellInfo.append(cellInfo(1))
        test2.subcellInfo.append(cellInfo(1))
        test2.subcellInfo.append(cellInfo(1))
        
        info.append(test)
        info.append(test2)
    }
    
    func loadXib(){
        let bundle = Bundle(identifier:"jerronimo.JKExpandableCalendar")
        let view = UINib(nibName: "JKExpandableCalendar", bundle: bundle).instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = self.bounds
        addSubview(view)
        tableView.register(UINib(nibName:"MainCell",bundle:bundle), forCellReuseIdentifier: "MainCell")
        tableView.register(UINib(nibName:"SecondaryCell",bundle:bundle), forCellReuseIdentifier: "SecondaryCell")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        if info[indexPath.row].type == 0{
            return setupMainCell(for: indexPath)
        }else{
            return setupSecondaryCell(for: indexPath)
        }
    }
    
    private func setupMainCell(for indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCell
        cell.delegate = self
        return cell
    }
    
    private func setupSecondaryCell(for indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondaryCell", for: indexPath)
        return cell
    }
}

extension JKExpandableCalendar:MainCellDelegate{
    func expandCell(_ cell:MainCell) {
        let index = tableView.indexPath(for: cell)!.row + 1
        let cellInfo = info[index - 1]
        if cellInfo.expanded{
            info.removeSubrange(index ..< index + cellInfo.subcellInfo.count)
            cellInfo.expanded = false
            tableView.reloadData()
        }else{
            info.insert(contentsOf: cellInfo.subcellInfo, at: index)
            cellInfo.expanded = true
            tableView.reloadData()
        }
    }
}
