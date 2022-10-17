//
//  LeaveLearnViewController.swift
//  MamNon
//
//  Created by Thắng Trương on 17/09/2022.
//

import UIKit

class LeaveLearnViewController: UIViewController {
    @IBOutlet weak var viewTable: UIView!
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var monthNowLabel: UILabel!
    var calendar:FSCalendar?
    var data:[LeaveModel] = []
    var fillDefaultColors:[String:Any]?
    var monthNext = 0

    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initTable()
        self.addViewHeader()
        self.getMonthNow()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getDataHistory()

    }
    
    func getMonthNow(){
        
        let timestamp = Utilities.getCurrentTimestamp()
        monthNowLabel.text = "Tháng " + (Double(timestamp).convertToDate().getPreviousOrNextMonth(value: monthNext)?.getMonthAndYear() ?? "")
    }
    
    func addViewHeader(){
        let header = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as? HeaderView
        header?.setupUI(rootView: viewHeader)
        viewHeader.addSubview(header!)
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
            calendar.appearance.todayColor = UIColor.init(rgba: "#FFE3BF")
            calendar.select(self.dateFormatter.date(from: Common().getNowDate()))
            calendar.backgroundColor = UIColor.init(rgba: "#FFFAF4")
            calendar.firstWeekday = 2
            calendar.scrollEnabled = true
            calendar.appearance.selectionColor = .clear
            calendar.appearance.titleSelectionColor = .black
            
        }
        

    }
    
    func initTable() {
        self.table.delegate = self
        self.table.dataSource = self
        self.table.register(UINib (nibName: "LeaveLearnTableViewCell", bundle: nil), forCellReuseIdentifier: "LeaveLearnTableViewCell")
    }
    
    @IBAction func didSelectAddLeave(_ sender: Any) {
        let v = CreateLeaveLearnViewController()
        self.navigationController?.pushViewController(v, animated: true)
    }
    @IBAction func didSelectBackDate(_ sender: Any) {

    }
    @IBAction func didSelectNextDate(_ sender: Any) {
                
    }
    @IBAction func didBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension LeaveLearnViewController : FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let key = self.dateFormatter.string(from: date)
        if let color = self.fillDefaultColors?[key] {
            return color as! UIColor
        }
        return nil
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.initCalendar()
        let d = Common.convertDateYYYYMMdd(date: date)
        let v = PopupActiveDayViewController()
        v.date = d
        v.modalPresentationStyle = .overFullScreen
        self.present(v, animated: true)
        
    }
    
}

extension LeaveLearnViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaveLearnTableViewCell", for: indexPath) as! LeaveLearnTableViewCell
        cell.configCell(data: self.data[indexPath.row])
        return cell
    }
    
    
}

extension LeaveLearnViewController {
    func getDataHistory() {
        LeaveService().getDataHistoryLeaveLearn { response in
            if let data = response["data"] as? [[String:Any]] {
                for item in data {
                    if let model = LeaveModel (JSON: item) {
                        for it in model.datesArr {
                            let md = LeaveModel (JSON: [:])
                            md?.dates = it
                            md?.note = model.note
                            md?.statusString = model.statusString
                            md?.createdAt = model.createdAt
                            if let m = md {
                                self.data.append(m)
                            }
                            if self.fillDefaultColors != nil {
                                self.fillDefaultColors?[it] = UIColor.init(rgba:"#27AE60")
                            }else {
                                self.fillDefaultColors = [it:UIColor.init(rgba:"#27AE60")]
                                
                            }
                            
                        }
                        
                    }
                }
                self.initCalendar()
                self.table.reloadData()
            }
        } failure: { err in
            
        }

    }
    

}
