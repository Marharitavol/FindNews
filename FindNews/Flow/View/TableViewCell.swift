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
    let addToFavorite = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: TableViewCell.identifierCell)
        setupCell()
        addToFavorite.addTarget(self, action: #selector(setupAddToFavoriteButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        
        let horizontalStackView = UIStackView(arrangedSubviews: [source, author])
        horizontalStackView.axis = .horizontal
        
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
        
        contentView.addSubview(addToFavorite)
        addToFavorite.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.size.equalTo(50)
        }
        addToFavorite.setImage(UIImage(systemName: "heart"), for: .normal)
        addToFavorite.tintColor = .red
    }
    
    func congigure(article: Article) {
        source.text = article.source.name
        author.text = article.author
        articleTitle.text = article.title
        articleDescription.text = article.description
        let url = URL(string: article.urlToImage ?? "")
        articleImage.kf.setImage(with: url)
    }
    
    @objc func setupAddToFavoriteButton() {
        
        if addToFavorite.tag == 0 {
            addToFavorite.setImage(UIImage(systemName: "heart"), for: .normal)
            addToFavorite.tag = 1
        } else {
            addToFavorite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            addToFavorite.tag = 0
        }
    }
}
