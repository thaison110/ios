//
//  CreateLeaveLearnViewController.swift
//  MamNon
//
//  Created by Truong Thang on 23/09/2022.
//

import UIKit
import SVProgressHUD

class CreateLeaveLearnViewController: UIViewController {
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalLeaveDateLabel: UILabel!
    @IBOutlet weak var noteTxt: UITextView!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var leaveButton: UIButton!
    @IBOutlet weak var viewCollectDates: UIView!
    @IBOutlet weak var cstTopDate: NSLayoutConstraint!
    @IBOutlet weak var viewHeader: UIView!
    var calendar:FSCalendar?
    var dates:[String] = []
    let placeHolderTxt = "Nhập lý do xin nghỉ"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.noteTxt.delegate = self
        self.initCalendar()
        self.hidenTitleDate()
        self.initCollection()
        self.addViewHeader()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    
    func initCollection() {
        self.collection.delegate = self
        self.collection.dataSource = self
        self.collection.register(UINib (nibName: "CreateLeaveCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CreateLeaveCollectionViewCell")
    }
    
    func initPlaceHolder() {
        noteTxt.text = placeHolderTxt
        noteTxt.textColor = UIColor.lightGray
    }
    
    func addViewHeader(){
        let header = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as? HeaderView
        header?.setupUI(rootView: viewHeader)
        viewHeader.addSubview(header!)
    }

    @IBAction func didSelectBackMonth(_ sender: Any) {
    }
    @IBAction func didSelectNextMonth(_ sender: Any) {
    }
    @IBAction func didSelectBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func didSelectCreateLeave(_ sender: Any) {
        self.getSendDataLeave()
    }
    
    func getSendDataLeave() {
        let txt = self.noteTxt.text
        if txt != placeHolderTxt,txt?.count ?? 0 > 0 {
            if self.dates.count > 0 {
                SVProgressHUD.show()
                LeaveService().getSendDataLeave(note: txt ?? "", dates: self.dates.joined(separator: ",")) { [weak self] response in
                    SVProgressHUD.dismiss()
                    if let status = response["status"] as? Int, status == 200 {
                        self?.showToast(message: "Đã gửi thành công!\nĐang chờ nhà trường xác nhận!")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self?.navigationController?.popViewController(animated: true)
                        }
                        
                    }else {
                        self?.showToast(message: "Lỗi kết nối.Xin vui lòng thử lại")
                    }
                } failure: { err in
                    SVProgressHUD.dismiss()
                    self.showToast(message: "Lỗi kết nối.Xin vui lòng thử lại")
                    
                }

            }else {
                self.showToast(message: "Chọn ngày xin nghỉ")
            }
        }else {
            self.showToast(message: "Không được để trống lý do xin nghỉ")
        }
        
        

    }
    
}

extension CreateLeaveLearnViewController {
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
            calendar.backgroundColor = UIColor.init(rgba: "#FFFAF4")
            calendar.firstWeekday = 2
            calendar.scrollEnabled = true
        }
    }
}

extension CreateLeaveLearnViewController : FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
//        let key = self.dateFormatter1.string(from: date)
//        if let color = self.fillDefaultColors[key] {
//            return color
//        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return true
    }
    
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        let d = Common.convertDateYYYYMMdd(date: date)
        if let idx = self.dates.firstIndex(where: {$0 == d}) {
            self.dates.remove(at: idx)
        }
        self.hidenTitleDate()
        return true
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("")
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let d = Common.convertDateYYYYMMdd(date: date)
        self.dates.append(d)
        self.hidenTitleDate()
        
        
    }
    
    func hidenTitleDate() {
        if self.dates.count > 0 {
            self.leaveButton.alpha = 1
            self.cstTopDate.constant = 0
        }else {
            self.leaveButton.alpha = 0.6
            self.cstTopDate.constant = -80
            self.initPlaceHolder()
        }
        self.totalLeaveDateLabel.text = "Ngày xin nghỉ (\(self.dates.count))"
        self.collection.reloadData()
        self.calendar?.reloadData()
    }
    
    

    
}

extension CreateLeaveLearnViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreateLeaveCollectionViewCell", for: indexPath) as! CreateLeaveCollectionViewCell
        cell.dateLabel.text = self.dates[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: 120, height: self.collection.frame.height)
    }
    
}

extension CreateLeaveLearnViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
}
