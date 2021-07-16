
//
//  AddPostPickerView.swift
//  InstagramClone
//
//  Created by ashutosh on 12/07/21.
//

import SwiftUI
import PhotosUI

struct SelectImageToPostView : View{
    @Environment(\.presentationMode) var presentable
    @State private var inputImage : UIImage?
    @State private var image : Image?
    @State var isImageSelected = false
    @State var index = 1
    var body: some View{
                ZStack{
                    if index==1{
                    Color.black.ignoresSafeArea()
                VStack{
                    HStack{
                        Text("Cancel").font(.system(size: 18)).foregroundColor(.white).padding(.leading)
                            .onTapGesture {
                                self.presentable.wrappedValue.dismiss()
                            }
                        Spacer()
                        Text("New Post").font(.system(size: 18)).bold().foregroundColor(.white)
                        Spacer()
                        Text("Next").font(.system(size: 18))
                            .foregroundColor(.white).foregroundColor(.blue).padding(.trailing)
                            .onTapGesture {
                                self.index=2
                            }
                    }
                    ZStack{
                        if image != nil{
                            image?
                                .resizable()
                                .scaledToFit()
                                .frame(width:Screen.maxWidth,height: Screen.maxWidth*0.8)
                        }else{
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width:Screen.maxWidth,height: Screen.maxWidth*0.8)
                        }
                    }.onAppear{
                        if self.isImageSelected{
                            loadImage()
                        }
                    }
                  
                    Spacer()
                    AddPostPickerView(inputImage: $inputImage, isImageSelected: $isImageSelected, image: $image).frame(height:Screen.maxHeight*0.5)
                }.navigationBarHidden(true)
                    }else{
                        MakePostView(image: $image, uiImage: $inputImage)
                }
        }
    }
 
   func loadImage() {
    print("function called")
        guard let inputImage = inputImage else {
            return
        }
        image = Image(uiImage: inputImage)
    }
}


struct AddPostPickerView : UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController
    @Binding var inputImage : UIImage?
    @Binding var isImageSelected : Bool
    @Binding var image : Image?
    @Environment(\.presentationMode) var presentable
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    class Coordinator : NSObject,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
        var parent : AddPostPickerView
        init(parent : AddPostPickerView){
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                   parent.inputImage = uiImage
                parent.isImageSelected=true
                guard let input = parent.inputImage else {
                    return
                }
                parent.image = Image(uiImage: input)
              
               }
        
            
        }
      
    }
}

struct AddPostPickerView_Previews: PreviewProvider {
    static var previews: some View {
        AddPostPickerView(inputImage: .constant(UIImage()), isImageSelected: .constant(false), image: .constant(Image("post1")))
    }
}
