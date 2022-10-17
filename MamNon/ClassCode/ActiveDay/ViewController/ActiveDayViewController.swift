//
//  ActiveDayViewController.swift
//  MamNon
//
//  Created by Truong Thang on 01/10/2022.
//

import UIKit

class ActiveDayViewController: UIViewController {
    var dataActive:[ActivateModel] = []
//    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var monthNowLabel: UILabel!
    @IBOutlet weak var table: UITableView!
    var calendar:FSCalendar?
    var date:String = ""
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.initTable()
        self.addViewHeader()
        self.setupData(date: Date())
//        self.initCalendar()
    }

    func getDay() -> (String,Bool) {
        let dateD = Common.convertStringToDate(dateString: date)
        let d:Double = dateD.timeIntervalSince1970
        let day = d.convertToDay()
        
        var isCheck = true
        if day == "T7" && day == "CN" {
            isCheck = false
        }
        
        return (day.replacingOccurrences(of: "T", with: "Thứ "),isCheck)
    }
    
    func setupData(date:Date) {
        self.date = Common.convertDateYYYYMMdd(date: date)
        self.monthNowLabel.text = "\(getDay().0),Ngày \(Common.convertDateYYYYMMddToDDMMYYYY(dateString: self.date))"
        self.getDataActiveDay(date: self.date)
    }
    
    
    
    func addViewHeader(){
        let header = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as? HeaderView
        header?.setupUI(rootView: viewHeader)
        viewHeader.addSubview(header!)
    }
    
    func initTable() {
        self.table.delegate = self
        self.table.dataSource = self
        self.table.sectionHeaderHeight = UITableView.automaticDimension
        self.table.rowHeight = UITableView.automaticDimension
        self.table.register(UINib (nibName: "BoardHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "BoardHomeTableViewCell")
        self.table.register(UINib (nibName: "HeaderDateActiveDayTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderDateActiveDayTableViewCell")
    }
    
    
    func initCalendar() {
        calendar?.removeFromSuperview()
        calendar = FSCalendar(frame: self.calendarView.frame)
        if let calendar = calendar {
            calendar.dataSource = self
            calendar.delegate = self
            calendar.allowsMultipleSelection = true
            calendar.swipeToChooseGesture.isEnabled = true
            self.view.addSubview(calendar)
            self.calendarView = calendar
            calendar.select(self.dateFormatter.date(from: Common().getNowDate()))
            calendar.backgroundColor = UIColor.init(rgba: "#FFFAF4")
            calendar.firstWeekday = 2
            calendar.scrollEnabled = true
            calendar.appearance.todayColor = UIColor.init(rgba: "#FFE3BF")
            calendar.appearance.selectionColor = UIColor.init(rgba: "#FFC312")
            calendar.appearance.titleSelectionColor = .black

        }
        

    }
    
    func getDataActiveDay(date: String) {
        self.dataActive.removeAll()
        self.table.reloadData()
        LeaveService().getDataActiveDay(date: date) { response in
            if let data = response["data"] as? [[String:Any]] {
                for item in data {
                    if let ac = ActivateModel (JSON: item) {
                        self.dataActive.append(ac)
                    }
                }
                
            }
            self.table.reloadData()
        } failure: { err in
            
        }

    }
    
    @IBAction func pressedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension ActiveDayViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BoardHomeTableViewCell", for: indexPath) as! BoardHomeTableViewCell
        cell.configCell(data: self.dataActive)
        cell.icArrow.isHidden = true
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.dataActive.count > 0 {
            let height = (self.dataActive.count) * 60 + 40
            return CGFloat(height)
        }
        return 0
    }
    
}

extension ActiveDayViewController : FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {


    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.setupData(date: date)
    }
    
}
