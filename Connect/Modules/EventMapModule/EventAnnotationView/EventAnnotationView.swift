//
//  EventAnnotationView.swift
//  Connect
//
//  Created by Tamerlan Satualdypov on 21.03.2021.
//

import Foundation
import Mapbox

final class EventAnnotationView : MGLAnnotationView {
    
    private var imageView : UIImageView!
    
    private var image : UIImage?
    
    override internal func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.bounds.width / 2
        
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        
        self.backgroundColor = .systemBlue
        
        self.imageView.frame = .init(x: 0, y: 0, width: 24, height: 24)
        self.imageView.center = .init(x: 16, y: 16)
    }
    
    required init(reuseIdentifier: String?, image: UIImage) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.clipsToBounds = true
        
        self.imageView = UIImageView()
        
        self.imageView.image = image.withRenderingMode(.alwaysTemplate)
        self.imageView.contentMode = .scaleAspectFit
        
        self.imageView.tintColor = .white
        
        self.addSubview(self.imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}
