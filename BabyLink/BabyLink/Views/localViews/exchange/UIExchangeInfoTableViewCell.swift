//
//  UIExchangeInfoTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/26.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit

protocol UIChooseDelegate:NSObjectProtocol{
    func didChooseAtIndexRow(row:Int);
}

class UIExchangeInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var chooseBtn: UIButton!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    weak var delegate:UIChooseDelegate!;
    var indexRow:Int = 0;
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backView.layer.cornerRadius = 4;
        self.backView.layer.masksToBounds = true;
        chooseBtn.selected = true;
//        chooseBtn.enabled = false;
    }

    func setContentData(exchange:NSExchange, inexRow row:Int){
        self.indexRow = row;
        chooseBtn.selected = true;
        self.contentImage.sd_setImageWithURL(NSURL(string: exchange.image_url), placeholderImage: nil)
        titleLabel.text = exchange.from_gname;
        timeLabel.text = exchange.add_time;
    }
    
    @IBAction func chooseGoods(sender: UIButton) {
//        sender.selected = !sender.selected;
//        delegate.didChooseAtIndexRow(self.indexRow);
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
