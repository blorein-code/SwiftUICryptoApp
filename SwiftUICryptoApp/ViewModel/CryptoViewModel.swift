//
//  CryptoViewModel.swift
//  SwiftUICryptoApp
//
//  Created by Berke Topcu on 22.11.2022.
//

import Foundation

//Eğer view model'in tamamını main thread'de çalıştırmak istiyorsak yani (Dispatchqueue) kullanmamak için. sayfanın başına @MainActor ekleyebiliriz.


//Observableobject önemli.
//ObservableObject class ile kullanılıyor. Puslished yapmazsak bir yayınlanma olmadığından gözlemlenme de olmaz.
class CryptoListViewModel : ObservableObject {
    
   @Published var cryptoList = [CryptoViewModel]()
    
    let webservice = Webservice()
    
    
    //escaping to await async hali
    func downloadCryptosContinuation(url:URL) async {
        do {
        let cryptos = try await webservice.downloadCurrenciesContinuation(url: url)
            DispatchQueue.main.async {
                self.cryptoList = cryptos.map(CryptoViewModel.init)
            }
            
        } catch {
            print(error)
        }
        
    }
    
    
    
    //Async hali
    /*
    func downloadCryptosAsync(url: URL) async {
        do {
            let cryptos = try await webservice.downloadCurrenciesAsync(url: url)
            
            DispatchQueue.main.async {
                self.cryptoList = cryptos.map(CryptoViewModel.init)
            }
        } catch {
            print(error)
        }
        
    }
    */
    
    
    
    
    //escaping hali
    /*
    func downloadCryptos(url:URL) {
        
        webservice.downloadCurrencies(url: url) { result in
            
            switch result {
                case .failure(let error):
                    print(error)
            case .success(let cryptos):
                if let cryptos = cryptos {
                    DispatchQueue.main.async {
                        self.cryptoList = cryptos.map(CryptoViewModel.init)
                    }
                    
                }
            }
        }
    }*/
}




struct CryptoViewModel {
    
    let crypto : CryptoCurrency
    
    var id : UUID? {
        crypto.id
        
    }
    
    var currency : String {
        crypto.currency
    }
    
    var price : String {
        crypto.price
    }
    
}
