//
//  CommentTableViewCell.swift
//  BabyLink
//
//  Created by 黄倩 on 15/11/8.
//  Copyright © 2015年 黄倩. All rights reserved.
//

import UIKit


class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setContentData(comment:NSTalkCommentObject, withHolder member_id:String){
        if comment.to_id == member_id {
            let content = "\(comment.from_name)：\(comment.info)" as NSString;
            contentLabel.attributedText = content.switchContentWithFonts([UIFont.systemFontOfSize(12)], withRanges: [NSStringFromRange(NSMakeRange(0, (comment.from_name as NSString).length))], withColors: [SRedBtnColor]);
        } else {
            let content = "\(comment.from_name)回复\(comment.to_name)：\(comment.info)" as NSString;
            contentLabel.attributedText = content.switchContentWithFonts([UIFont.systemFontOfSize(12),UIFont.systemFontOfSize(12)], withRanges: [NSStringFromRange(NSMakeRange(0, (comment.from_name as NSString).length)),NSStringFromRange(NSMakeRange((comment.from_name as NSString).length+2, (comment.to_name as NSString).length))], withColors: [SRedBtnColor,SRedBtnColor]);
        }
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
