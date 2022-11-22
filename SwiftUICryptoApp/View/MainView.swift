//
//  ContentView.swift
//  SwiftUICryptoApp
//
//  Created by Berke Topcu on 22.11.2022.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var cryptoListViewModel : CryptoListViewModel
    
    init() {
        self.cryptoListViewModel = CryptoListViewModel()
    }
    
    var body: some View {
        NavigationView {
            List(cryptoListViewModel.cryptoList, id:\.id){ crypto in
                
                VStack{
                    Text(crypto.currency)
                        .font(.title3)
                        .foregroundColor(.purple)
                        
                    Text(crypto.price)
                        .foregroundColor(.black)
                }
                
            }.toolbar(content: {
                Button {
                    //tıklanınca olacaklar
                    //butonu async hale getirmek için task.init içerisine yazdık kodları
                    Task.init {
                        await cryptoListViewModel.downloadCryptosContinuation(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
                    }
                } label: {
                    //buton nasıl gözüksün
                    Text("Refresh")
                }

            })
            
            .navigationTitle(Text("Crypto Crazy"))
        }.task{
            
            //escaping to await async hali
            
            await cryptoListViewModel.downloadCryptosContinuation(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
            
            
            //Async hali
            /*
            await cryptoListViewModel.downloadCryptosAsync(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
             */
        }
        /*
         //Escaping hali
        .onAppear {
            
            cryptoListViewModel.downloadCryptos(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
             */
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
