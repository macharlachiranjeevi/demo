//
//  ViewController.swift
//  JanCalenderDemo
//
//  Created by chiranjeevi macharla on 17/01/17.
//  Copyright © 2017 chiranjeevi macharla. All rights reserved.
//

import UIKit
class ViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate{

    @IBOutlet var collectionView: UICollectionView!
    var selectionMode = true
    var selectedIndexes: NSMutableArray = []
    var pan : UIPanGestureRecognizer!
    var startingRow : NSInteger!

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndexes = []
        collectionView.delegate = self
        collectionView.dataSource = self

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 42, height: 42)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        collectionView!.collectionViewLayout = layout
        collectionView.allowsMultipleSelection = true
        pan = UIPanGestureRecognizer.init(target: self, action: #selector(didPanToSelectCells(sender:)))
        collectionView.addGestureRecognizer(pan)
        pan.delegate = self
        pan.cancelsTouchesInView = false
        collectionView.addGestureRecognizer(pan)


    }

    func didPanToSelectCells( sender: UIPanGestureRecognizer) {

        let location = sender.location(in: collectionView)
        let indexPath = collectionView.indexPathForItem(at: location)
         if indexPath?.section == 1{
        if !selectionMode {
            collectionView.isScrollEnabled = true
            return
        } else {
            if pan.state == UIGestureRecognizerState.began{

                collectionView.isUserInteractionEnabled = false
                collectionView.isScrollEnabled = false



                startingRow = indexPath?.row

                for i in 0 ..< self.items.count  {
                    let newIndexPath = IndexPath(row: i, section: 1)
                    let cell = collectionView!.cellForItem(at: newIndexPath)
                    cell?.backgroundColor = UIColor.white
                }

                selectedIndexes.removeAllObjects()


            }else if pan.state == UIGestureRecognizerState.changed{
                let location = sender.location(in: collectionView)
                let indexPath = collectionView.indexPathForItem(at: location)

                if !selectedIndexes.contains(indexPath?.row ?? 0){
                    if startingRow > (indexPath?.row)! {

                        var last = (indexPath?.row)!
                        last = last - 1
                        for index in stride(from: startingRow, to: last, by: -1){

                            let newIndexPath = IndexPath(row: index, section: 1)
                            let cell = collectionView!.cellForItem(at: newIndexPath)


                            if newIndexPath.row % 7 == 5 || newIndexPath.row % 7 == 6{
                                cell?.backgroundColor = UIColor.white
                            } else {
                                cell?.backgroundColor = UIColor.red
                                selectedIndexes .add(newIndexPath.row)
                            }



                        }

                    

                    } else {
                        for i in startingRow ... (indexPath?.row)!  {
                            let newIndexPath = IndexPath(row: i, section: 1)
                            let cell = collectionView!.cellForItem(at: newIndexPath)
                            //                            cell?.backgroundColor = UIColor.red
                            //                            selectedIndexes .add(newIndexPath.row)


                            if newIndexPath.row % 7 == 5 || newIndexPath.row % 7 == 6{
                                cell?.backgroundColor = UIColor.white
                            } else {
                                cell?.backgroundColor = UIColor.red
                                selectedIndexes .add(newIndexPath.row)
                            }
                        }
                    }

                } else {

                    for i in 0 ..< self.items.count  {
                        let newIndexPath = IndexPath(row: i, section: 1)
                        let cell = collectionView!.cellForItem(at: newIndexPath)
                        cell?.backgroundColor = UIColor.white
                    }
                    selectedIndexes.removeAllObjects()

                    if startingRow > (indexPath?.row)! {

                        var last = (indexPath?.row)!
                        last = last - 1
                        for index in stride(from: startingRow, to: last, by: -1){

                            let newIndexPath = IndexPath(row: index, section: 1)
                            let cell = collectionView!.cellForItem(at: newIndexPath)
                            //                            cell?.backgroundColor = UIColor.red

                            if newIndexPath.row % 7 == 5 || newIndexPath.row % 7 == 6{
                                cell?.backgroundColor = UIColor.white
                            } else {
                                cell?.backgroundColor = UIColor.red
                                selectedIndexes .add(newIndexPath.row)
                            }



                            //                            selectedIndexes .add(newIndexPath.row)
                        }



                    } else {
                        for i in startingRow ... (indexPath?.row)!  {
                            let newIndexPath = IndexPath(row: i, section: 1)
                            let cell = collectionView!.cellForItem(at: newIndexPath)
                            //                            cell?.backgroundColor = UIColor.red

                            if newIndexPath.row % 7 == 5 || newIndexPath.row % 7 == 6{
                                cell?.backgroundColor = UIColor.white
                            } else {
                                cell?.backgroundColor = UIColor.red
                                selectedIndexes .add(newIndexPath.row)
                            }

                            //                            selectedIndexes .add(newIndexPath.row)
                        }
                    }

                }







            }else if pan.state == UIGestureRecognizerState.ended{

                let location = sender.location(in: collectionView)
                let indexPath = collectionView.indexPathForItem(at: location)

                if startingRow == indexPath?.row {
                    let newIndexPath = IndexPath(row: startingRow, section: 1)
                    let cell = collectionView!.cellForItem(at: newIndexPath)
                    cell?.backgroundColor = UIColor.white
                    selectedIndexes.removeAllObjects()
                }
                
                collectionView.isScrollEnabled = true
                collectionView.isUserInteractionEnabled = true
            }
        }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    let reuseIdentifier = "DateCollectionViewCell" // also enter this string as the cell identifier in the storyboard
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"]

    var weeks = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 7
        }
        else{
    return self.items.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! DateCollectionViewCell
        if indexPath.section == 0 {
        cell.dateLbl.text = self.weeks[indexPath.item]
            cell.dateLbl.textColor = UIColor.white
            cell.backgroundColor = UIColor.blue
        }
        else{
            cell.dateLbl.text = self.items[indexPath.item]
            cell.backgroundColor = UIColor.cyan
        }



         // make cell more visible in our example project
        return cell
    }
    // MARK: - UICollectionViewDelegate protocol


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.size.width/7;
        return CGSize.init(width: width, height: width);
    }


}

