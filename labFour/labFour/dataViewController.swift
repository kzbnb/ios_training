//
//  dataViewController.swift
//  labFour
//
//  Created by yzh on 2020/12/11.
//  Copyright © 2020 yzh. All rights reserved.
//

import UIKit
import Foundation

class dataViewController: UIViewController ,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    //文字大小
    let  textViewFont =  UIFont .systemFont(ofSize: 22)
    
    @IBAction func takePhoto(_ sender: Any) {
        let imagePicker=UIImagePickerController()
        if
            UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            imagePicker.delegate=self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
//        insertPicture( UIImage:, mode:.fitTextView)
    }
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var contentView: UITextView!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage=info[UIImagePickerController.InfoKey.originalImage]
            as? UIImage else {return;}
        insertPicture(image: selectedImage, mode:.fitTextView)
        dismiss(animated: true, completion: nil)
    }
    
    var memoForEdit:memo?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let memo=memoForEdit{
            //赋值
            self.titleText.text=memo.title;
            self.contentView.attributedText=memo.content;
            print(contentView.attributedText)
            
        }
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destination.
//         Pass the selected object to the new view controller.


        if segue.identifier=="save"{
            let date = Date()
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "yyyy/MM/dd";
            memoForEdit=memo(title:titleText.text!,date:timeFormatter.string(from: date),content:contentView!.attributedText)
        }
    }
    
    
    //插入文字
    func  insertString(_ text: String ) {
        //获取textView的所有文本，转成可变的文本
        let  mutableStr =  NSMutableAttributedString (attributedString: contentView.attributedText)
        //获得目前光标的位置
        let  selectedRange = contentView.selectedRange
        //插入文字
        let  attStr =  NSAttributedString (string: text)
        mutableStr.insert(attStr, at: selectedRange.location)

        //设置可变文本的字体属性
        mutableStr.addAttribute( NSAttributedString.Key.font , value: textViewFont,
                                 range:  NSMakeRange (0,mutableStr.length))
        //再次记住新的光标的位置
        let  newSelectedRange =  NSMakeRange (selectedRange.location + attStr.length, 0)

        //重新给文本赋值
        contentView.attributedText = mutableStr
        //恢复光标的位置（上面一句代码执行之后，光标会移到最后面）
        contentView.selectedRange = newSelectedRange
    }

    //插入图片
    func  insertPicture(image: UIImage , mode: ImageAttachmentMode  = . fitTextView ){
        //获取textView的所有文本，转成可变的文本
        print(contentView.attributedText)
        let  mutableStr =  NSMutableAttributedString (attributedString: contentView.attributedText)
        //创建图片附件
        let  imgAttachment =  NSTextAttachment (data:  nil , ofType:  nil )
        var  imgAttachmentString:  NSAttributedString
        imgAttachment.image = image

        //设置图片显示方式
//        if  mode == .fitTextLine {
//            //与文字一样大小
//            imgAttachment.bounds =  CGRect (x: 0, y: -4, width: textView.font!.lineHeight,
//                                            height: textView.font!.lineHeight)
//        }  else
            if  mode == .fitTextView {
            //撑满一行
            let  imageWidth = contentView.frame.width - 10
            let  imageHeight = image.size.height/image.size.width*imageWidth
            imgAttachment.bounds =  CGRect (x: 0, y: 0, width: imageWidth, height: imageHeight)
        }

        imgAttachmentString =  NSAttributedString (attachment: imgAttachment)

        //获得目前光标的位置
        let  selectedRange = contentView.selectedRange
        //插入文字
        mutableStr.insert(imgAttachmentString, at: selectedRange.location)
        //设置可变文本的字体属性
        mutableStr.addAttribute( NSAttributedString.Key.font , value: textViewFont,
                                 range:  NSMakeRange (0,mutableStr.length))
        //再次记住新的光标的位置
        let  newSelectedRange =  NSMakeRange (selectedRange.location+1, 0)

        //重新给文本赋值
        contentView.attributedText = mutableStr
        //恢复光标的位置（上面一句代码执行之后，光标会移到最后面）
        contentView.selectedRange = newSelectedRange
        //移动滚动条（确保光标在可视区域内）
        self.contentView.scrollRangeToVisible(newSelectedRange)
    }

    //插入的图片附件的尺寸样式
    enum  ImageAttachmentMode  {

        case  fitTextLine   //使尺寸适应行高
        case  fitTextView   //使尺寸适应textView
    }
}
