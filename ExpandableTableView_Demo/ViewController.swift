//
//  ViewController.swift
//  ExpandableTableView_Demo
//
//  Created by 준수김 on 2021/10/19.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var tableViewDataModel = [cellData(opened: false, image: "당근", title: "채소", sectionData: ["전체보기", "친환경", "나머지"]),
                         cellData(opened: false, image: "사과", title: "과일·견과·쌀", sectionData: ["전체보기", "친환경", "나머지"]),
                         cellData(opened: false, image: "생선", title: "수산 해산·건어물", sectionData: ["전체보기", "제철수산", "나머지"]),
                         cellData(opened: false, image: "고기", title: "정육·계란", sectionData: ["전체보기", "국내산 소고기", "나머지"]),
                         cellData(opened: false, image: "밥", title: "국·반찬·메인요리", sectionData: ["전체보기", "국·탕·찌개", "나머지"]),
                         cellData(opened: false, image: "샐러드", title: "샐러드·계란", sectionData: ["전체보기", "샐러드·닭가슴살", "나머지"]),
                         cellData(opened: false, image: "양념", title: "면·양념·오일", sectionData: ["전체보기", "파스타면류", "나머지"])]
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        //tabbar 색 바꾸기
        self.navigationController?.navigationBar.backgroundColor = .purple
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}


// MARK: - UITableViewDataSource

extension ViewController : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewDataModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewDataModel[section].opened == true {
            // tableView Section이 열려있으면 Section Cell 하나에 sectionData 개수만큼 추가해줘야 함
            return tableViewDataModel[section].sectionData.count + 1
        } else {
            // tableView Section이 닫혀있을 경우에는 Section Cell 하나만 보여주면 됨
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // section 부분 코드
        if indexPath.row == 0 {

            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            
            cell.foodImage.image = UIImage(named: tableViewDataModel[indexPath.section].image)
            cell.foodName?.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
            cell.foodName?.text = tableViewDataModel[indexPath.section].title
            return cell
            
        // sectionData 부분 코드
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            cell.accessoryType = .none //펼쳐지는 부분에는 악세서리 없애기
            cell.foodName?.text = tableViewDataModel[indexPath.section].sectionData[indexPath.row - 1]
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 셀 선택 시 회색에서 다시 변하게 해주는 것
        tableView.deselectRow(at: indexPath, animated: true)
        
        // section 부분 선택하면 열리게 설정
        if indexPath.row == 0 {
            // section이 열려있다면 다시 닫힐 수 있게 해주는 코드
            tableViewDataModel[indexPath.section].opened = !tableViewDataModel[indexPath.section].opened
            
            // 모든 데이터를 새로고침하는 것이 아닌 해당하는 섹션 부분만 새로고침
            tableView.reloadSections([indexPath.section], with: .none)
        
        // sectionData 부분을 선택하면 아무 작동하지 않게 설정
        } else {
            print("이건 sectionData 선택한 거야")
        }
        
        print([indexPath.section], [indexPath.row])

        
    }
    
}
