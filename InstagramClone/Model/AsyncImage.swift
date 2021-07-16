//
//  AsyncImage.swift
//  InstagramClone
//
//  Created by ashutosh on 14/07/21.
//

import SwiftUI
import Combine
struct AsyncImage<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Placeholder

    init(url: URL, @ViewBuilder placeholder: () -> Placeholder) {
        self.placeholder = placeholder()
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    var body: some View {
        if loader.image != nil {
                        Image(uiImage: loader.image!)
                            .resizable()
                    } else {
                        placeholder
                    }
    }

    private var content: some View {
        placeholder
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
        private let url: URL
    private var cancellable: AnyCancellable?
    init(url: URL) {
           self.url = url
       }
    func load() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}
