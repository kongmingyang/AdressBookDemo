//
//  AddressbookController.swift
//  HomeSystem
//
//  Created by 明孔 on 2019/8/5.
//  Copyright © 2019 明孔. All rights reserved.
//

import UIKit
let tableVeiwCell = "UITableViewCell"
protocol AdressBookDataSourece : NSObjectProtocol {
    func adressBookListDatas() -> Array<Any>
}
class AddressbookController: UIViewController {
   var tableView : UITableView!
    //分组数据源
    var dataSource : AdressBookDataSourece!
    
    var sectionTitleArr = [String]()
    
    var locationCollection : UILocalizedIndexedCollation!
    //每组数据源
    var dataArray = [[Human]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "通讯录"
//        let datas = self.dataSource.adressBookListDatas()
//      print(datas)
        let names = ["赵","钱","孙","李","周","吴","郑","王","郭","松","宋","长","大","小","博爱","boai","小明", "陆晓峰","石少庸是小明的老师","石少庸", "Alix", "Tom","Lucy","123","cydn","mami","888", "zhangSan","王二","微信","张小龙","黎明", "李明","李盆儿","李数","李写","刘盆偶","刘蜀都赋","刘是打发","李上", "刘第三方"];
        var humans = [Human]()
        
        for name in names {
           let human = Human.init(name: name)
            humans.append(human)
        }
        
        //初始化UILocalizedIndexedCollation
        self.locationCollection = UILocalizedIndexedCollation.current()
        
        //得出collation索引的数量，这里是27个（26个字母和1个#）

        let indexCount = self.locationCollection.sectionTitles.count
      
        //每一个一维数组可能有多个数据要添加，所以只能先创建一维数组，到时直接取来用
        for _ in 0..<indexCount {
            
            let array = [Human]()
            self.dataArray.append(array)
        }
        
        //将数据进行分类，存储到对应数组中
        for human in humans {
            // 根据 person 的 name 判断应该放入哪个数组里
            // 返回值就是在 indexedCollation.sectionTitles 里对应的下标
            let sectionNumber = self.locationCollection.section(for: human, collationStringSelector: #selector(getter: Human.name))
            //添加到对应一堆数组中
            self.dataArray[sectionNumber].append(human)
        }
        
        //对每个已经分类的一位数组里的数据进行排序，如果仅仅只是分类可以不用这一步
        for i in 0 ..< indexCount {
            //排序结果数组
            let sortedPersonArray = self.locationCollection.sortedArray(from: self.dataArray[i], collationStringSelector:#selector( getter: Human.name))
            //替换原来数组
            self.dataArray[i] = sortedPersonArray as![Human]
            
        }

        //用来保存没有数据的一维数组的下标
        var tempArray = [Int]()
        for (i , array) in self.dataArray.enumerated() {
           
            if array.count == 0{
                tempArray.append(i)
            }else{
             
                  self.sectionTitleArr.append(self.locationCollection.sectionTitles[i])
               
            }
            
            
        }
      
        //删除没有数据的数组
        for i in tempArray.reversed() {
            dataArray.remove(at: i)
        }
        self.tableView = UITableView.init(frame: UIScreen.main.bounds)
        self.tableView.delegate = self;
        self.tableView.sectionIndexColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        //修改背景色
        self.tableView.sectionIndexBackgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        //修改点击时的颜色
        self.tableView.sectionIndexTrackingBackgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = .none
        self.view.addSubview(self.tableView)
        self.tableView.estimatedRowHeight = 150
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView .register(UITableViewCell.self, forCellReuseIdentifier: tableVeiwCell)
       
        
        
    }
    


}
extension AddressbookController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionTitleArr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionTitleArr[section]
    }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        return self.sectionTitleArr
}
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: tableVeiwCell, for: indexPath)
        let humman = self.dataArray[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = humman.name
  
        return cell
        
        
}

}

class Human:NSObject  {
    @objc var name : String?

    init(name:String) {
        self.name = name;
    }
}
