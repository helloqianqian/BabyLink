//
//  UIOptionView.swift
//  LeDoingHome
//
//  Created by 黄倩 on 15/11/11.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

enum DataType:Int{
    case none
    case birthday
//    case city
//    case district
    case range
}

protocol UIOptionViewDelegate:NSObjectProtocol{
    func didRemoveFromSuperView(object:AnyObject ,dataType type:DataType);
    func didSelectedRow(row:Int, forComponent component: Int);
}

class UIOptionView: UIView ,UIPickerViewDelegate,UIPickerViewDataSource{

    @IBOutlet weak var pickerView: UIPickerView!
    weak var delegate:UIOptionViewDelegate!;
    var dataType = DataType.none;
    @IBOutlet weak var tapGesture: UITapGestureRecognizer!
    var dataArray:NSMutableArray! = NSMutableArray();
    
    var selectedArray = [0,0,0,0,0];
    
    var currentYear = 1970;
    var currentMonth = 11;
    var currentDay = 30;
    override func awakeFromNib() {
        self.addGestureRecognizer(tapGesture);
        
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        self.pickerView.showsSelectionIndicator = true;
        
        self.currentYear = NSHelper.currentYear();
        self.currentMonth = NSHelper.currentMonth();
        self.currentDay = NSHelper.currentDay();
    }
    
    @IBAction func closeViewAndReturnData(sender: UITapGestureRecognizer) {
        if self.dataType == DataType.birthday {
            selectedArray[0] = self.currentYear - self.pickerView.selectedRowInComponent(0);
            selectedArray[1] =  self.pickerView.selectedRowInComponent(1)+1;
            selectedArray[2] = self.pickerView.selectedRowInComponent(2)+1;
            delegate.didRemoveFromSuperView(selectedArray, dataType: self.dataType);
        } else if self.dataType == DataType.range {
            delegate.didRemoveFromSuperView(dataArray.objectAtIndex(self.pickerView.selectedRowInComponent(0)), dataType: self.dataType);
        }
        self.removeFromSuperview();
    }
    
    
    //MARK: - UIPickerViewDataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        switch self.dataType {
        case DataType.none:
            return 0;
        case DataType.birthday:
            return 3;
        case DataType.range:
            return 1;
        }
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch self.dataType {
        case DataType.none:
            return 0;
        case DataType.birthday:
            if component == 0 {
                return 45;
            } else if component == 1 {
                return 12;
            } else {
                return 31;
            }
        case DataType.range:
            return 4;
        }
    }
    
    //MARK: - UIPickerViewDelegate
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch self.dataType {
        case DataType.none:
            let string = dataArray.objectAtIndex(row) as! String;
            return string;
        case DataType.birthday:
            if component == 0 {
                return "\(currentYear - row)"
            } else {
                return "\(row+1)";
            }
        case DataType.range:
            let string = dataArray.objectAtIndex(row) as! String;
            return string;
        }
        
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch self.dataType {
        case DataType.none:
            selectedArray[0] = row;
            break;
        case DataType.birthday:
            let year = self.currentYear - self.pickerView.selectedRowInComponent(0);
            var month =  self.pickerView.selectedRowInComponent(1);
            var day = self.pickerView.selectedRowInComponent(2);
            if year == self.currentYear {
                if month >= self.currentMonth-1 {
                    self.pickerView.selectRow(self.currentMonth-1, inComponent: 1, animated: true);
                    month =  self.pickerView.selectedRowInComponent(1);
                    if day >= self.currentDay {
                        self.pickerView.selectRow(self.currentDay-1, inComponent: 2, animated: true);
                        day = self.pickerView.selectedRowInComponent(2);
                    }
                }
            }
            
            
            if month == 1 {
                if year%100 == 0 {
                    if year%400 == 0 {
                        if day > 28 {
                            self.pickerView.selectRow(28, inComponent: 2, animated: true);
                        }
                    } else {
                        if day > 27 {
                            self.pickerView.selectRow(27, inComponent: 2, animated: true);
                        }
                    }
                } else if year%4==0 {
                    if day > 28 {
                        self.pickerView.selectRow(28, inComponent: 2, animated: true);
                    }
                } else {
                    if day > 27 {
                        self.pickerView.selectRow(27, inComponent: 2, animated: true);
                    }
                }
            } else if month == 3 || month == 5 || month == 8 || month == 10{
                if day == 30 {
                    self.pickerView.selectRow(29, inComponent: 2, animated: true);
                }
            }
            
            break;
        case DataType.range:
            selectedArray[0] = row;
            break;
        }
        delegate.didSelectedRow(row, forComponent: component);
    }
    func changeDataSource(type:DataType){
        switch type {
        case DataType.range:
            self.dataType = DataType.range;
            dataArray.removeAllObjects();
            dataArray.addObjectsFromArray(["父子","母子","父女","母女"]);
            self.pickerView.reloadAllComponents();
            break;
        case DataType.birthday:
            self.dataType = DataType.birthday;
            self.pickerView.reloadAllComponents();
            break;
        case DataType.none:
            self.dataType = DataType.none;
            dataArray.removeAllObjects();
            break;
        }
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
