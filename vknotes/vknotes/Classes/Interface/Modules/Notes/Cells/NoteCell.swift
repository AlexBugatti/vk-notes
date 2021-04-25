//
//  NoteCell.swift
//  vknotes
//
//  Created by Александр on 25.04.2021.
//

import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView! {
        didSet {
            self.containerView.layer.cornerRadius = 10
            self.containerView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    func configure(note: Note) {
        self.titleLabel.text = note.title
        self.categoryLabel.text = note.category
        self.noteLabel.text = note.note
    }
    
}
