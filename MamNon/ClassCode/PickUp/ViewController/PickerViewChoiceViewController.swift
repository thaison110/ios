//
//  PickerViewChoiceViewController.swift
//  MamNon
//
//  Created by Ngo Thuy on 21/09/2022.
//

import UIKit

protocol PickerViewChoiceViewControllerDelegate {
    func choiceItem(index: Int, text: String)
}

class PickerViewChoiceViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerView: UIPickerView!
    var arrayPicker : [String] = []
    var indexChoice : Int = 0
    var delegate : PickerViewChoiceViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.delegate = self
        self.pickerView.reloadAllComponents()
        // Do any additional setup after loading the view.
       
        self.pickerView.selectRow(indexChoice, inComponent: 0, animated: false)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @IBAction func pressedClose(_ sender: Any) {
        if let delegate = self.delegate {
            delegate.choiceItem(index: indexChoice, text: arrayPicker[indexChoice])
            self.dismiss(animated: false)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayPicker.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayPicker[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        indexChoice = row
    }

}
