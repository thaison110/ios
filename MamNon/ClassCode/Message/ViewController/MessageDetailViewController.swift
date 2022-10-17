//
//  MessageDetailViewController.swift
//  MamNon
//
//  Created by Ngo Thuy on 17/09/2022.
//

import UIKit

class MessageDetailViewController: UIViewController , UITextViewDelegate{
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var imageSendChat: UIImageView!
    @IBOutlet weak var labelPlaceHoder: UILabel!
    @IBOutlet weak var heightViewTyping: NSLayoutConstraint!
    @IBOutlet weak var textViewChat: UITextView!
    @IBOutlet weak var viewHeader: UIView!
    
    @IBOutlet weak var cstBottomViewTyping: NSLayoutConstraint!
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelSubTitle: UILabel!
    @IBOutlet weak var tabelViewChat: UITableView!
    var personChat : ChatPersonModel?
    var arrayMessage : [MessageChatModel] = []
    var isCheckSendMessage : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViewHeader()
        // Do any additional setup after loading the view.
        self.textViewChat.delegate = self
        setShadow()
        tabelViewChat.register(UINib(nibName: "MessageRightItemTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageRightItemTableViewCell")
        tabelViewChat.register(UINib(nibName: "MessageLeftItemTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageLeftItemTableViewCell")
        initNotification()
        loadData()
    }
    
    func loadData(){
        if let obj = self.personChat{
            imageAvatar.sd_setImage(with: URL(string: obj.avatar), placeholderImage: UIImage(named: "ic_AvatarDefaul"))
            self.labelName.text = obj.name
        }
        self.getHistoryMessage()
    }
    
    
    func removeNotificationKeyBoard() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func initNotification() {
        // keybroad
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHidden),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
    }
    
    func setShadow(){
        // corner radius
        viewContent.layer.cornerRadius = 12

        // border
        viewContent.layer.borderWidth = 1.0
        viewContent.layer.borderColor = UIColor.white.cgColor

        // shadow
        viewContent.layer.shadowColor = UIColor.lightGray.cgColor
        viewContent.layer.shadowOffset = CGSize(width: 1, height: 1)
        viewContent.layer.shadowOpacity = 0.7
        viewContent.layer.shadowRadius = 4.0
    }
    

    func addViewHeader(){
        let header = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as? HeaderView
        header?.setupUI(rootView: viewHeader)
        viewHeader.addSubview(header!)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            updateFrameBottomViewTyping(bottom: keyboardHeight - Common.getBottomPadding() - 40)
        }
    }
    
    @objc func keyboardWillHidden(_ notification: Notification) {
       
        updateFrameBottomViewTyping(bottom: 20)
    }
    
    
    func UpdateHeightViewComment()  {
        var heightTextView = self.textViewChat.contentSize.height
        let calcHeightTextView =  self.textViewChat.sizeThatFits(self.textViewChat.frame.size).height //iOS 8+ only
        
        print("heightTextView: \(heightTextView)" )
        print("calcHeightTextView: \(calcHeightTextView)"  )
        heightTextView = calcHeightTextView
        if(calcHeightTextView != heightTextView){
            heightTextView = calcHeightTextView
        }
        if (heightTextView > 24.5 + 21.5*3) {
            heightTextView = 24.5 + 21.5*3
        }else if heightTextView < 46 {
            heightTextView = 46
        }
        updateHeightViewTyping(hight: heightTextView)
//        heightTextView = heightTextView + 8
//        self.heightViewComment.constant = heightTextView + self.heighViewRepUser
//        var heightViewComment = heightTextView + 16
//        if heightViewComment < 56 {
//            heightViewComment = 56
//        }
       
    }
    
    func updateFrameBottomViewTyping(bottom:CGFloat){
        UIView.animate(withDuration: 1.5, delay: 0, options: [],
                       animations: {
                        self.cstBottomViewTyping.constant = bottom
        },
                       completion: nil
        )
    }
    
    func updateHeightViewTyping(hight:CGFloat){
        UIView.animate(withDuration: 0.6, delay: 0.3, options: [],
                       animations: {
                        self.heightViewTyping.constant = hight
        },
                       completion: nil
        )
    }
 
    func textViewDidChange(_ textView: UITextView) {
        UpdateHeightViewComment()
        if self.textViewChat.text.count > 0 {
            self.labelPlaceHoder.isHidden = true
            self.imageSendChat.image = UIImage(named: "ic_SendMessage")
        }else{
            self.labelPlaceHoder.isHidden = false
            self.imageSendChat.image = UIImage(named: "ic_UnSendMessage")
        }
    }
    @IBAction func pressedSendMessage(_ sender: Any) {
        self.textViewChat.endEditing(true)
        if let message : String = textViewChat.text{
            let messageTrim = message.trim()
            if messageTrim.count > 0 {
                sendMessage(message: messageTrim)
            }
            
        }
        
        
        
    }
    
    @IBAction func pressedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func sendMessage(message: String){
        if isCheckSendMessage {
            return
        }
        isCheckSendMessage = true
        let messageService = MessageService()
        messageService.sendChatMessage(self.personChat?.id ?? 0, message: message) { respone in
            self.isCheckSendMessage = false
            if let responseModel = MetaResponse(JSON: respone){
                if responseModel.status == 200{
                    self.textViewChat.text = ""
                    self.labelPlaceHoder.isHidden = false
                    var array : [MessageChatModel] = []
                    if let data  = respone["data"] as? [[String: Any]]{
                        for item  in data.reversed() {
                            if let obj = MessageChatModel(JSON: item){
                                array.append(obj)
                            }
                           
                        }
                           
                    }
                    self.arrayMessage = array
                    self.tabelViewChat.reloadData()
                    self.scrollToBottom()
                }
            
            }
            
        } failure: { error in
            self.isCheckSendMessage = false
        }

    }

    func getHistoryMessage(){
        let messageService = MessageService()
        messageService.getHistoryMessage(self.personChat?.id ?? 0) { respone in
            if let responseModel = MetaResponse(JSON: respone){
                if responseModel.status == 200{
                    var array : [MessageChatModel] = []
                    if let data  = respone["data"] as? [[String: Any]]{
                        for item  in data.reversed() {
                            if let obj = MessageChatModel(JSON: item){
                                array.append(obj)
                            }
                           
                        }
                           
                    }
                    self.arrayMessage = array
                    self.tabelViewChat.reloadData()
                    self.scrollToBottom()
                    
                   
                }
            
            }
            
        } failure: { error in
            
        }

    }
    func scrollToBottom(){
        if arrayMessage.count > 0{
            tabelViewChat.scrollToRow(at: IndexPath(row: arrayMessage.count - 1, section: 0), at: .bottom, animated: true)
        }
    }
}

extension MessageDetailViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let obj = arrayMessage[indexPath.row]
        if obj.sender_id != GlobalData.sharedInstance.userLogin?.id {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageRightItemTableViewCell", for: indexPath) as! MessageRightItemTableViewCell
            cell.getData(obj: arrayMessage[indexPath.row])
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageLeftItemTableViewCell", for: indexPath) as! MessageLeftItemTableViewCell
            cell.getData(obj: arrayMessage[indexPath.row])
            return cell
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
