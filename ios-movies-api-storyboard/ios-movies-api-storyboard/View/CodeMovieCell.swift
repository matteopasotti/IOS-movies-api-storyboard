//
//  CodeMovieCell.swift
//  ios-movies-api-storyboard
//
//  Created by Matteo Pasotti on 07/06/2020.
//  Copyright © 2020 Matteo Pasotti. All rights reserved.
//

import UIKit

final class CodeMovieCell: UITableViewCell {

    let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor,
                                          multiplier: 1.26).isActive = true
        imageView.clipsToBounds = true
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    let avgLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        stackView.alignment = .center
        stackView.spacing = 16

        let labelStackView = UIStackView()
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.axis = .vertical

        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(avgLabel)

        stackView.addArrangedSubview(movieImage)
        stackView.addArrangedSubview(labelStackView)

        selectionStyle = .none

        contentView.addContentView(stackView)
    }

    override func layoutSubviews() {
        movieImage.layer.cornerRadius = movieImage.frame.size.height / 10
    }
}

extension CodeMovieCell {
    func configure(imageStringUrl: String, title: String, avg: String) {
        movieImage.imageDownload(from: imageStringUrl)
        titleLabel.text = title
        avgLabel.text = avg
    }
}

extension UIView {
    public func addContentView(_ subView: UIView) {
        addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: topAnchor),
            subView.bottomAnchor.constraint(equalTo: bottomAnchor),
            subView.leftAnchor.constraint(equalTo: leftAnchor),
            subView.rightAnchor.constraint(equalTo: rightAnchor)])
    }

}
