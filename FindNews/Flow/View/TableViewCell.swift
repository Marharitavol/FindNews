//
//  TableViewCell.swift
//  FindNews
//
//  Created by Rita on 20.01.2022.
//

import UIKit
import SnapKit
import Kingfisher

class TableViewCell: UITableViewCell {
    
    static let identifierCell = String(describing: ViewController.self)
    
    let source = UILabel()
    let author = UILabel()
    let articleTitle = UILabel()
    let articleDescription = UILabel()
    let articleImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: TableViewCell.identifierCell)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let horizontalStackView = UIStackView(arrangedSubviews: [source, author])
        horizontalStackView.axis = .horizontal
        //horizontalStackView.distribution = .fillEqually
        
        articleImage.contentMode = .scaleAspectFill
        articleImage.clipsToBounds = true
        articleImage.snp.makeConstraints { (make) in
            make.height.equalTo(120)
        }
        
        let stackView = UIStackView(arrangedSubviews: [articleImage, horizontalStackView, articleTitle, articleDescription])
        stackView.axis = .vertical
        stackView.spacing = 8
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(8)
        }
        
        source.numberOfLines = 0
        author.numberOfLines = 0
        articleTitle.numberOfLines = 0
        articleTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 15.0)
        articleDescription.numberOfLines = 0
        articleDescription.font = UIFont(name:"HelveticaNeue", size: 10.0)
       
    }
    
    func congigure(article: Article) {
        source.text = article.source.name
        author.text = article.author
        articleTitle.text = article.title
        articleDescription.text = article.description
        let url = URL(string: article.urlToImage ?? "")
        articleImage.kf.setImage(with: url)
    }
    
}
