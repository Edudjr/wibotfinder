//
//  SwinjectStoryboard+Extension.swift
//  WiFinder
//
//  Created by Eduardo Domene Junior on 15/11/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    @objc class func setup() {
        defaultContainer.register(RequestProtocol.self) { _ in
            AlamofireRequest()
        }
        defaultContainer.register(ITunesAPIProtocol.self) { r in
            ITunesAPI(provider: r.resolve(RequestProtocol.self)!)
        }
        defaultContainer.register(CatalogModelProtocol.self) { r in
            CatalogModel(iTunesAPI: r.resolve(ITunesAPIProtocol.self)!)
        }
        defaultContainer.storyboardInitCompleted(CatalogViewController.self) { r, c in
            c.catalogModel = r.resolve(CatalogModelProtocol.self)
        }
    }
}
