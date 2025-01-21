//
//  CollectionAnimationVC+Extension+CollectionView.swift
//  demoAnimation
//
//  Created by apple on 18/04/24.
//

import UIKit

//MARK :- Collection View Property
typealias collectionViewProprty = UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

extension CollectionAnimationVC : collectionViewProprty{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return total_no_of_cell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_reusable_identifier, for: indexPath)
        
//        cell.alpha = 0
        cell.backgroundColor = .purple
        
        cell.alpha = 0
    
        
        
        
        
        switch selectedAnimationType{
        case .fadeIn:
            Animations.fadeIn(cell: &cell)
            break
        case .indexDelay(.fastMode) :
            Animations.indexDelay(at: indexPath.row, completion: {
                cell.alpha = 1
            }, delayMode: .fastMode)
            break
        case .indexDelay(.slowMode):
            Animations.indexDelay(at: indexPath.row, completion: {
                cell.alpha = 1
            }, delayMode: .slowMode)
            break
            
        case .distanceDelay :
            Animations.distanceDelay(cell: cell, completion: {
                cell.alpha = 1
            })
            
            break
        case .transition :
            cell.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            Animations.transitionEffect(cell: cell, completion: {
                cell.alpha = 1
                cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            })
            break
        }
       

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CollectionAnimationVC.cell_width, height: CollectionAnimationVC.cell_hight)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
            
    }
       
}
