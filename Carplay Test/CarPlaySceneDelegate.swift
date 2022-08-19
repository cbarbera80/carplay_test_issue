//
//  CarPlaySceneDelegate.swift
//  Carplay Test
//
//  Created by Claudio Barbera on 18/08/22.
//

import Foundation
import CarPlay

class CarPlaySceneDelegate: UIResponder, CPTemplateApplicationSceneDelegate {
    lazy var templateManager = TemplateManager()
    
    func templateApplicationScene(
        _ templateApplicationScene: CPTemplateApplicationScene,
        didConnect interfaceController: CPInterfaceController
    ) {
        templateManager.connect(interfaceController)
    }
    
    func templateApplicationScene(
        _ templateApplicationScene: CPTemplateApplicationScene,
        didDisconnectInterfaceController interfaceController: CPInterfaceController
    ) {
        templateManager.disconnect()
    }
}


class TemplateManager: NSObject {
    private var controller: CPInterfaceController?
    
    func connect(_ interfaceController: CPInterfaceController) {
        
        controller = interfaceController
        buildNewTemplate()
    }
    
    func disconnect() {
        controller = nil
    }
    
    @available(iOS 14.0, *)
    func buildNewTemplate() {
        
        let favouriteBooksSection =  buildListSection(
            items: [
                (title: "Primo elemento", subtitle: "Sottotitolo"),
                (title: "Secondo elemento", subtitle: "Sottotitolo"),
                (title: "Terzo elemento", subtitle: "Sottotitolo")
                ],
            title: "La tua lista"
        )
        
        let booksTemplate: CPListTemplate = CPListTemplate(title: "Libri", sections: [favouriteBooksSection,])
        booksTemplate.tabTitle = "Libri"
        booksTemplate.tabImage = UIImage(systemName: "book")
        
        let tabBartemplate = CPTabBarTemplate(templates: [booksTemplate])
        controller?.setRootTemplate(tabBartemplate, animated: true, completion: nil)
    }
  
    @available(iOS 14.0, *)
    private func buildListSection(items: [(title: String, subtitle: String)], title: String) -> CPListSection {
        
        let listItems = items.map { item -> CPListItem in
            
            let item = CPListItem(text: item.title, detailText: item.subtitle)
            
            item.handler = { [weak self] item, completion in
                
                let nowPlayingTemplate = CPNowPlayingTemplate.shared
                nowPlayingTemplate.add(self!)
                nowPlayingTemplate.isAlbumArtistButtonEnabled = true
                
                self?.controller?.pushTemplate(nowPlayingTemplate, animated: true, completion: nil)
                
                completion()
            }
            
            return item
        }
        
        return CPListSection(items: listItems, header: title, sectionIndexTitle: nil)
    }
}

@available(iOS 14.0, *)
extension TemplateManager: CPNowPlayingTemplateObserver {
    func nowPlayingTemplateUpNextButtonTapped(_ nowPlayingTemplate: CPNowPlayingTemplate) {}
    
    func nowPlayingTemplateAlbumArtistButtonTapped(_ nowPlayingTemplate: CPNowPlayingTemplate) {}
}
