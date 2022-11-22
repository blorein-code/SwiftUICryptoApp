//
//  Webservice.swift
//  SwiftUICryptoApp
//
//  Created by Berke Topcu on 22.11.2022.
//

import Foundation


class Webservice {
    
    
    //With escaping olarak kurdugumuz function'ı await async formatına döndürerek kullanabildiğimiz yapı.
    func downloadCurrenciesContinuation(url: URL) async throws -> [CryptoCurrency] {
        
        try await withCheckedThrowingContinuation({ continuation in
            
            downloadCurrencies(url: url) { result in
                switch result {
                case.success(let cryptos):
                    continuation.resume(returning: cryptos ?? [])
                case.failure(let error):
                    continuation.resume(throwing: error)
                }
            }
            
        })
        
    }
    
    
   /*
    //Async
    //Async olduğu için await alır.
    //Gerektiği durumda error döneceği için Try kullanılası gerek.
    //Error dönecegini belirtmek için async throws
    func downloadCurrenciesAsync(url:URL) async throws -> [CryptoCurrency] {
        
      let (data, _ ) = try await URLSession.shared.data(from: url)
        
        let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data)
        
        return currencies ?? []
    }
}
 */
    
    //With escaping
    func downloadCurrencies(url:URL, completion:@escaping (Result<[CryptoCurrency]?,downloaderError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.badUrl))
            }
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            guard let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data) else {
                return completion(.failure(.dataParseError))
            }
            
            completion(.success(currencies))
            //İşlemlere devam etmek için
        }.resume()
    }
}


    
//Hata durumunda enumda belirtilen hatalar dönüyor bu da nerde sorun oldugunu bulmamıza kolaylık sağlıyor.
enum downloaderError : Error {
    case badUrl
    case noData
    case dataParseError
}
