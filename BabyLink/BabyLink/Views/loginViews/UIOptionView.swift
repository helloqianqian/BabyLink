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
    case activityTime
    case jiheTime
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
            
        } else if self.dataType == DataType.range {
            
        }
        
        
        switch self.dataType {
        case .range:
            delegate.didRemoveFromSuperView(dataArray.objectAtIndex(self.pickerView.selectedRowInComponent(0)), dataType: self.dataType);
            break;
        case .birthday:
            selectedArray[0] = self.currentYear - self.pickerView.selectedRowInComponent(0);
            selectedArray[1] =  self.pickerView.selectedRowInComponent(1)+1;
            selectedArray[2] = self.pickerView.selectedRowInComponent(2)+1;
            delegate.didRemoveFromSuperView(selectedArray, dataType: self.dataType);
            break;
        case .activityTime:
            selectedArray[0] = self.currentYear + self.pickerView.selectedRowInComponent(0);
            selectedArray[1] =  self.pickerView.selectedRowInComponent(1)+1;
            selectedArray[2] = self.pickerView.selectedRowInComponent(2)+1;
            delegate.didRemoveFromSuperView(selectedArray, dataType: self.dataType);break;
        case .jiheTime:
            selectedArray[0] = self.currentYear + self.pickerView.selectedRowInComponent(0);
            selectedArray[1] =  self.pickerView.selectedRowInComponent(1)+1;
            selectedArray[2] = self.pickerView.selectedRowInComponent(2)+1;
            selectedArray[3] = self.pickerView.selectedRowInComponent(3)+1;
            selectedArray[4] = self.pickerView.selectedRowInComponent(4);
            delegate.didRemoveFromSuperView(selectedArray, dataType: self.dataType);break;
        case .none:break;
        }
        self.removeFromSuperview();
    }
    
    func showPickerView(){
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight);
            }) { (finish:Bool) -> Void in
                switch self.dataType {
                case .range:
                    break;
                case .birthday:
                    break;
                case .activityTime:
                    self.pickerView.selectRow(self.currentMonth-1, inComponent: 1, animated: true);
                    self.pickerView.selectRow(self.currentDay-1, inComponent: 2, animated: true);
                    break;
                case .jiheTime:
                    self.pickerView.selectRow(self.currentMonth-1, inComponent: 1, animated: true);
                    self.pickerView.selectRow(self.currentDay-1, inComponent: 2, animated: true);
                    break;
                case .none:
                    break;
                }
        }
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
        case .jiheTime:
            return 5;
        case .activityTime:
            return 3;
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
            return 5;
        case DataType.jiheTime:
            if component == 0 {
                return 45;
            } else if component == 1 {
                return 12;
            } else if component == 2 {
                return 31;
            } else if component == 3 {
                return 24;
            } else {
                return 60;
            }
        case DataType.activityTime:
            if component == 0 {
                return 45;
            } else if component == 1 {
                return 12;
            } else {
                return 31;
            }
        }
    }
    
    //MARK: - UIPickerViewDelegate
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat{
        switch self.dataType {
        case DataType.none:
            return MainScreenWidth;
        case DataType.birthday:
            return MainScreenWidth/3-10;
        case DataType.range:
            return MainScreenWidth;
        case DataType.activityTime:
            return MainScreenWidth/3-10;
        case DataType.jiheTime:
            switch component{
            case 0:return MainScreenWidth/5+5;
            case 1:return MainScreenWidth/5-7;
            case 2:return MainScreenWidth/5-7;
            case 3:return MainScreenWidth/5-7;
            case 4:return MainScreenWidth/5-7;
            default:return MainScreenWidth;
            }
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch self.dataType {
        case DataType.none:
            let string = dataArray.objectAtIndex(row) as! String;
            return string;
        case DataType.birthday:
            if component == 0 {
                return "\(currentYear - row)年"
            } else if component == 1{
                return "\(row+1)月";
            } else {
                return "\(row+1)日";
            }
        case DataType.range:
            let string = dataArray.objectAtIndex(row) as! String;
            return string;
        case DataType.activityTime:
            if component == 0 {
                return "\(currentYear + row)年"
            } else if component == 1{
                return "\(row+1)月";
            } else {
                return "\(row+1)日";
            }
        case DataType.jiheTime:
            switch component{
            case 0:return "\(currentYear + row)";
            case 1:return "\(row+1)";
            case 2:return "\(row+1)";
            case 3:return "\(row+1)";
            case 4:return "\(row)";
            default:return "";
            }
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
            let calculateDay = NSHelper.maxDayOfTheMonth(month, andYear: year, andSelectedDay: day)
            if calculateDay != day {
                self.pickerView.selectRow(calculateDay, inComponent: 2, animated: true);
            }
            break;
        case DataType.range:
            selectedArray[0] = row;
            break;
        case DataType.activityTime:
            let year = self.currentYear - self.pickerView.selectedRowInComponent(0);
            var month =  self.pickerView.selectedRowInComponent(1);
            var day = self.pickerView.selectedRowInComponent(2);
            
            if year == self.currentYear {
                if month <= self.currentMonth-1 {
                    self.pickerView.selectRow(self.currentMonth-1, inComponent: 1, animated: true);
                    month =  self.pickerView.selectedRowInComponent(1);
                    if day <= self.currentDay {
                        self.pickerView.selectRow(self.currentDay-1, inComponent: 2, animated: true);
                        day = self.pickerView.selectedRowInComponent(2);
                    }
                }
            }
            let calculateDay = NSHelper.maxDayOfTheMonth(month, andYear: year, andSelectedDay: day)
            if calculateDay != day {
                self.pickerView.selectRow(calculateDay, inComponent: 2, animated: true);
            }
            break;
        case DataType.jiheTime:
            let year = self.currentYear - self.pickerView.selectedRowInComponent(0);
            var month =  self.pickerView.selectedRowInComponent(1);
            var day = self.pickerView.selectedRowInComponent(2);
            
            if year == self.currentYear {
                if month <= self.currentMonth-1 {
                    self.pickerView.selectRow(self.currentMonth-1, inComponent: 1, animated: true);
                    month =  self.pickerView.selectedRowInComponent(1);
                    if day <= self.currentDay {
                        self.pickerView.selectRow(self.currentDay-1, inComponent: 2, animated: true);
                        day = self.pickerView.selectedRowInComponent(2);
                    }
                }
            }
            let calculateDay = NSHelper.maxDayOfTheMonth(month, andYear: year, andSelectedDay: day)
            if calculateDay != day {
                self.pickerView.selectRow(calculateDay, inComponent: 2, animated: true);
            }
            break;
        }
        delegate.didSelectedRow(row, forComponent: component);
    }
    func changeDataSource(type:DataType){
        switch type {
        case DataType.range:
            self.dataType = DataType.range;
            dataArray.removeAllObjects();
            dataArray.addObjectsFromArray(["父子","母子","父女","母女","其他"]);
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
        case DataType.jiheTime:
            NSHelper.TheDayFromCurrentDay(1, isYear: &self.currentYear, isMonth: &self.currentMonth, isDay: &self.currentDay)
            NSLog("\(self.currentYear),,,,\(self.currentMonth),,,,,\(self.currentDay)")
            self.dataType = DataType.jiheTime;
            self.pickerView.reloadAllComponents();
            break;
        case DataType.activityTime:
            NSHelper.TheDayFromCurrentDay(1, isYear: &self.currentYear, isMonth: &self.currentMonth, isDay: &self.currentDay)
            NSLog("\(self.currentYear),,,,\(self.currentMonth),,,,,\(self.currentDay)")
            self.dataType = DataType.activityTime;
            self.pickerView.reloadAllComponents();
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
